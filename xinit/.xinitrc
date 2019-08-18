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

#----- Custom lines

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set environment variables

#----- Editor & Browser
export EDITOR=emacs
export VISUAL=emacs
export BROWSER=firefox

#----- Locale
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_TIME=fr_CA.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

#----- XDG Base Directory
# From https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

# User-specific configuration files
export XDG_CONFIG_HOME=$HOME/.config

# User-specific data files
export XDG_DATA_HOME=$HOME/.local/share

# User-specific non-essential (cached) data
export XDG_CACHE_HOME=$HOME/.cache

# User-specific runtime files
# XDG_RUNTIME_DIR is already set through pam_systemd

# Colored man pages - source: https://github.com/imkira/dotfiles/blob/master/.zsh/colored-man-pages.zsh
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Set GPG TTY - source: https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
export GPG_TTY=$(tty)

# Add dotfiles' scripts to the PATH
# Add binaries installed for user to the PATH (pip, stack, cargo, etc...)
export PATH=$PATH:~/dotfiles/scripts:~/.local/bin:~/.cargo/bin

# If fzf is installed
if type fzf > /dev/null; then
  # Default command to use when input is tty (using the default 'fd' command)
  export FZF_DEFAULT_COMMAND='command fd --hidden --type file --no-ignore-vcs --exclude .git'

  # Default command for the CTRL+T key binding
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # Default command for the ALT+C key binding (using the default 'fd' command)
  export FZF_ALT_C_COMMAND='command fd --hidden --type directory --exclude .git'

  # Default colors, Solarized (Light)
  _fzf_default_colors() {
    # Commented colors are not used, but kept if I ever want to change this one day
    # local black='#002B36'
    local grey='#839496'
    # local dark_beige='#EEE8D5'
    local light_beige='#FDF6E3'
    local yellow='#B58900'
    # local orange='#CB4B16'
    # local red='#DC322F'
    # local magenta='#D33682'
    # local violet='#6C71C4'
    local blue='#268BD2'
    # local cyan='#2AA198'
    local green='#859900'

    export FZF_DEFAULT_COLORS="
      --color fg:$grey,bg:$light_beige,hl:$blue,fg+:$light_beige,bg+:$green,hl+:$blue
      --color info:$yellow,prompt:$yellow,pointer:$light_beige,marker:$light_beige,spinner:$yellow
    "
  }
  _fzf_default_colors

  # Keybinds to select, deselect and toggle all results
  export FZF_BIND_SELECT="--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"

  # Default layout (fullscreen and input from top)
  export FZF_LAYOUT="--min-height=100 --reverse"

  # Default options
  export FZF_DEFAULT_OPTS="$FZF_BIND_SELECT $FZF_LAYOUT $FZF_DEFAULT_COLORS"

  # For fzf-marks
  export MARKS_DIR="${XDG_CONFIG_HOME}/fzf-marks"
  export MARKS_FILE="${MARKS_DIR}/marks"
fi

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
  export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/pass/passwords"

  # Default length for generated passwords
  export PASSWORD_STORE_GENERATED_LENGTH=30
fi

# If ripgrep is installed
if type rg > /dev/null; then
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
fi

# Since Qt 5.6, Qt 5 applications can be instructed to honor screen DPI by setting the following ENV variable
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Start KDE session
exec startkde

#----- End of custom lines

# Call failsafe
exit 0
