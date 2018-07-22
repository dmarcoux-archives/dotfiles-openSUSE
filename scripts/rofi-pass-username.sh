#!/usr/bin/env bash

# A rofi frontend to pass (username in filenames; everything after =)
#
# Use with: rofi -modi "pass:/path/to/this_script.sh" -show pass-username

if [ -z "$*" ]; then
  # rofi first calls the script with no arguments

  # List full paths of logins stored by pass under $PASSWORD_STORE_DIR/pass
  # Keep the relative paths of these logins without the .gpg extension (just like how pass does it)
  find "$PASSWORD_STORE_DIR/pass" -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\\(.*\\)\\.gpg|\\1|g" | sort
else
  # Once the user selected a login, rofi calls the script again with the selected login as an argument

  # Retrieve the username for the selected login and copy it to the clipboard
  # Note: coproc starts the command group ({ ... }) as a background job (so it doesn't freeze rofi)
  coproc { echo "$*" | sed -e "s|^.*=\\(.*\\)|\\1|g" | xdotool type --clearmodifiers --file - > /dev/null & }
fi
