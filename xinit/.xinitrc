#!/usr/bin/env bash
# Everything in this file is from the sample .xinitrc for openSUSE, unless stated otherwise
# This script is called from 'startx' when you start an X session

# In case everything goes wrong, we at least fall back to a plain xterm
failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

# Some bash (1 and 2) settings to avoid trouble on a failed program call.
set +e > /dev/null 2>&1
set +u > /dev/null 2>&1
set +o posix  > /dev/null 2>&1
if type shopt > /dev/null 2>&1 ; then
    shopt -s execfail
else
    no_exit_on_failed_exec=1
fi

# Source common code shared between the X session and X init scripts
. /etc/X11/xinit/xinitrc.common

# Special for twm
case "$WINDOWMANAGER" in
    *twm) xsetroot -solid darkslateblue
esac

#----- Custom lines ----------

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set environment variables (so they are available in i3)

# If go is installed
if type go > /dev/null; then
  # Setup Go environment
  export GOPATH=~/projets/go
  export GOROOT=/usr/lib/go
  export PATH=$PATH:$GOPATH/bin
fi

# If pass is installed
if type pass > /dev/null; then
  # Do not pollute the home directory
  export PASSWORD_STORE_DIR=$XDG_CONFIG_HOME/pass/passwords
fi

# Add dotfiles' scripts to the PATH
export PATH=$PATH:~/dotfiles/scripts

# If stack is installed
if type stack > /dev/null; then
  # Recommendation from https://docs.haskellstack.org/en/stable/GUIDE/#downloading-and-installation
  export PATH=$PATH:~/.local/bin
fi

#----- End of custom lines ---

# Finally start the window manager
unset WINDOW_MANAGER STARTUP
exec $WINDOWMANAGER ${1+"$@"}

# Call failsafe
exit 0
