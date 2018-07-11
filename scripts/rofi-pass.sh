#!/usr/bin/env bash

# A rofi frontend to pass
#
# Use with: rofi -modi "pass:/path/to/this_script.sh" -show pass

if [ -z "$*" ]; then
  # rofi first calls the script with no arguments

  # List full paths of passwords stored by pass under $PASSWORD_STORE_DIR/pass
  # Keep the relative paths of these passwords without the .gpg extension (just like how pass does it)
  find "$PASSWORD_STORE_DIR/pass" -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\\(.*\\)\\.gpg|\\1|g" | sort
else
  # Once the user selected a password, rofi calls the script again with the selected password as an argument

  # Retrieve the password for the selected login and copy it to the clipboard
  # Note: coproc starts the command group ({ ... }) as a background job (so it doesn't freeze rofi)
  coproc { pass show "$*" | xdotool type --clearmodifiers --file - > /dev/null & }
fi
