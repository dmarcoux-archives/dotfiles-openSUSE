# If weechat is installed, set it up
if type weechat > /dev/null 2>&1; then
  weechat() {
    export WEECHAT_PASSPHRASE="$(pass pass/me/weechat_passphrase)"
    command weechat
  }

  # If inwee is installed, set it up
  if type inwee > /dev/null 2>&1; then
    configure_weechat() {
      inwee "$XDG_CONFIG_HOME"/weechat/settings.inwee
    }

    # Send text/commands to Weechat buffer
    inweeb() {
      if [ -z "$1" ]; then
        # Display usage if no parameters given
        echo "Usage: ${funcstack[1]} 'irc.freenode.#some-channel'"
        return
      fi

      inwee --buffer "$1"
    }
  fi
fi
