# If pass is installed, set it up
if type pass > /dev/null 2>&1; then
  # Setup new password
  nppp(){
    if [ -z "$1" ]; then
      # Display usage if no parameters given
      echo 'Usage: nppp me/some_website.com=account (account is the email/username in the login)'
      return
    fi

    pass insert pass/$1
  }

  # Setup new two-factor authentication code from a QR code image
  n2fa(){
    if [ -z "$@" ]; then
      echo 'Usage: n2fa qr_code.jpg work/some_website.com=account (account is the email/username in the login)'
      return
    fi

    zbarimg -q --raw $1 | pass otp insert otp/$2
  }
fi
