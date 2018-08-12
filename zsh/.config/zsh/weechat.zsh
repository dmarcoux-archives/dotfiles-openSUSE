# If weechat is installed, set it up
if type weechat > /dev/null 2>&1; then
  weechat() {
    export WEECHAT_PASSPHRASE="$(pass pass/me/weechat_passphrase)"
    command weechat
  }
fi
