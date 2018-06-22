# If fzf is installed, set it up
if type fzf > /dev/null 2>&1; then
  # Load default config files (completion and key bindings)
  # Completion at https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
  # Key bindings at https://github.com/junegunn/fzf#key-bindings-for-command-line
  source /etc/zsh_completion.d/fzf-key-bindings
fi
