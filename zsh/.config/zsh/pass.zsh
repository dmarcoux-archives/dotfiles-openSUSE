# If pass is installed, set it up
if type pass > /dev/null; then
  # Setup new password
  # Usage: nppp me/some_website=account
  # Note: account is the email/username in the login
  nppp(){
    pass insert pass/$1
  }

  # Setup new two-factor authentication code from a QR code image
  # Usage: n2fa qr_code.jpg work/some_website=whatever@email.com
  n2fa(){
    zbarimg -q --raw $1 | pass otp insert otp/$2
  }
fi
