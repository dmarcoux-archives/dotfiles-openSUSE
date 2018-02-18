# Do this first, then don't care about load order of config files loaded below, even if they set custom key bindings
set -o emacs # Use emacs key bindings

# Enable shell options
shopt -s globstar

# Load the config files
for config in ~/.config/bash/**/*.sh; do
  source $config
done
