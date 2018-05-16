if [[ -f /etc/zshrc ]]; then
  sudo --prompt="[sudo] password for root to remove /etc/zshrc (arbitrary defaults forced on users by openSUSE's zsh package): " rm /etc/zshrc
fi

# Do this first, then don't care about load order of config files loaded below, even if they set custom key bindings
bindkey -e # Use emacs key bindings

# Load the config files
for config (~/.config/zsh/**/*.zsh) source $config
