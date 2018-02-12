# If pass is installed, set it up
if type pass > /dev/null; then
  # Do not pollute the home directory
  export PASSWORD_STORE_DIR=$XDG_CONFIG_HOME/pass/passwords

  # Copy password to clipboard for a specific login
  ppp(){
    # List full paths of passwords stored by pass under $PASSWORD_STORE_DIR/pass
    # Keep the relative paths of these passwords without the .gpg extension (just like how pass does it)
    # Select one login with fzf
    # Retrieve the password for the selected login and copy it to the clipboard
    # TODO: Remove password from clipboard instead of clearing the whole clipboard history (Use CopyQ instead of Parcellite)
    find $PASSWORD_STORE_DIR/pass -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\(.*\)\.gpg|\1|g" | fzf --no-multi --reverse | xargs --no-run-if-empty pass show --clip
  }

  # Setup new password
  # Usage: nppp me/some_website=account
  # Note: account is the email/username in the login
  nppp(){
    pass insert pass/$1
  }

  # Copy two-factor authentication code to clipboard for a specific login
  2fa(){
    # List full paths of passwords stored by pass under $PASSWORD_STORE_DIR/otp
    # Keep the relative paths of these passwords without the .gpg extension (just like how pass does it)
    # Select one login with fzf
    # Retrieve the OTP code for the selected login and copy it to the clipboard
    find $PASSWORD_STORE_DIR/otp -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\(.*\)\.gpg|\1|g" | fzf --no-multi --reverse | xargs --no-run-if-empty pass otp --clip
  }

  # Setup new two-factor authentication code from a QR code image
  # Usage: n2fa qr_code.jpg work/some_website=whatever@email.com
  n2fa(){
    zbarimg -q --raw $1 | pass otp insert otp/$2
  }
fi
