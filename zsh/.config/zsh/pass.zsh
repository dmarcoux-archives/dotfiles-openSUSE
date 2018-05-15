# If pass is installed, set it up
if type pass > /dev/null 2>&1; then
  # Default length for generated passwords
  export PASSWORD_STORE_GENERATED_LENGTH=30

  # Setup new password
  new_password(){
    if [ -z "$1" ]; then
      # Display usage if no parameters given
      echo "Usage: ${funcstack[1]} me/some_website.com=account (account is the email/username in the login)"
      return
    fi

    pass insert "pass/$1"
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
