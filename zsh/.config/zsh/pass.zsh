# If pass is installed, set it up
if type pass > /dev/null 2>&1; then
  # Setup new password
  new_password(){
    if [ -z "$1" ]; then
      # Display usage if no parameters given
      echo "Usage: ${funcstack[1]} me/some_website.com=account (account is the email/username in the login)"
      return
    fi

    pass insert "pass/$1"
  }

  # Setup new generated password
  new_generated_password(){
     if [ -z "$1" ]; then
      # Display usage if no parameters given
      echo "Usage: ${funcstack[1]} me/some_website.com=account [password_length] (account is the email/username in the login)"
      return
    fi

    # Whenever the password length wasn't provided, it will default to PASSWORD_STORE_GENERATED_LENGTH
    pass generate --clip "pass/$1" "$2"
  }

  # Select a password with fzf and regenerate it
  # TODO: Decide when the length as to be provided (otherwise it's the default length)
  regenerate_password(){
    find "$PASSWORD_STORE_DIR/pass" -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\(.*\)\.gpg|\1|g" | fzf | xargs --no-run-if-empty pass generate --clip
  }

  # Setup new two-factor authentication code from a QR code image
  new_2fa(){
    if [ -z "$1" ] || [ -z "$2" ]; then
      echo "Usage: ${funcstack[1]} qr_code.jpg work/some_website.com=account (account is the email/username in the login)"
      return
    fi

    zbarimg --quiet --raw "$1" | pass otp insert "otp/$2"
  }
fi
