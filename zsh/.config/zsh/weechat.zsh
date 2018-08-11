# If weechat is installed, set it up
if type weechat > /dev/null 2>&1; then
  alias weechat="WEECHAT_PASSPHRASE="$(pass pass/me/weechat_passphrase)" weechat"
fi
