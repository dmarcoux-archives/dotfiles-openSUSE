# If weechat is installed, set it up
if type weechat > /dev/null 2>&1; then
  weechat() {
    export WEECHAT_PASSPHRASE="$(pass pass/me/weechat_passphrase)"
    command weechat
  }

  # If inwee is installed, set it up
  if type inwee > /dev/null 2>&1; then
    # Set default options for inwee
    inwee() {
      command inwee --fifo "$WEECHAT_HOME"/weechat_fifo "$@"
    }

    configure_weechat() {
      if [ ! -e "$WEECHAT_HOME"/weechat_fifo ]; then
        echo "Launch weechat before configuring it"
        return
      fi

      # Settings which need to be expanded before being passed to inwee
      echo "/secure set znc_password "$(pass pass/me/znc=dmarcoux)"" | inwee

      # All settings without expansion are in settings.inwee
      inwee "$WEECHAT_HOME"/settings.inwee
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
