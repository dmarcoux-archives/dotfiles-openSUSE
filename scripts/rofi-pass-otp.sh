#!/usr/bin/env bash

# A rofi frontend to pass-otp
#
# Use with: rofi -modi "pass-otp:/path/to/this_script.sh" -show pass-otp

if [ -z "$@" ]; then
  # rofi first calls the script with no arguments

  # List full paths of one-time passwords stored by pass under $PASSWORD_STORE_DIR/otp
  # Keep the relative paths of these one-time passwords without the .gpg extension (just like how pass does it)
  find $PASSWORD_STORE_DIR/otp -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\(.*\)\.gpg|\1|g"
else
  # Once the user selected an entry, rofi calls the script again with it as an argument

  # Retrieve the one-time password for the selected login and copy it to the clipboard
  # Note: coproc starts the command as a background job (so it doesn't freeze rofi)
  coproc (pass otp --clip "$@" > /dev/null &)
fi
