# If emacs is installed, set it up
if type emacs > /dev/null 2>&1; then
  alias em='emacs'
  # Script from dotfiles/scripts, which is in the PATH
  alias emacs='emacs_client.sh'

  # Edit emacs' desktop file to launch emacs from an interactive shell, which will expand the alias defined above
  if grep -Fxq 'Exec=emacs %F' /usr/share/applications/emacs.desktop; then
    sudo --prompt="[sudo] password for root to change emacs' Exec in emacs.desktop to use emacsclient: " sed --in-place 's/Exec=.*/Exec=emacs_client.sh %F/' /usr/share/applications/emacs.desktop
  fi

  # emacs' package on openSUSE installs a default config in the user's directory. It prevent spacemacs from installing.
  [[ -f ~/.emacs ]] && rm ~/.emacs
fi
