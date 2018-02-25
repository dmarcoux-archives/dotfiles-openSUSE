# Do this first, then don't care about load order of config files loaded below, even if they set custom key bindings
set -o emacs # Use emacs key bindings

# Enable shell options with 'shopt'. Details at https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# The pattern ‘**’ used in a filename expansion context will match all files and zero or more directories and subdirectories. If the pattern is followed by a ‘/’, only directories and subdirectories match.
shopt -s globstar
# Replaces directory names with the results of word expansion when performing filename completion. This changes the contents of the readline editing buffer
shopt -s direxpand
# Aliases are expanded
shopt -s expand_aliases

# Load the config files
for config in ~/.config/bash/**/*.sh; do
  source $config
done
