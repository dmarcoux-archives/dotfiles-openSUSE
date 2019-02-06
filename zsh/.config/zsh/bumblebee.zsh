# If bumblebee is supported, optirun/primusrun should be installed, setup aliases
if type optirun > /dev/null 2>&1; then
  alias nvidia-settings='optirun -b none nvidia-settings -c :8'
fi
