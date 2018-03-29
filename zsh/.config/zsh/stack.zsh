# If stack is installed, set it up
if type stack > /dev/null 2>&1; then
  eval "$(stack --bash-completion-script stack)"
fi
