ealias sysd='systemctl'
alias shutdown='sudo shutdown now'
alias reboot='sudo reboot now'

# Output all active and running systemd services (beside the core systemd services)
alias services="systemctl list-units -t service --no-pager --no-legend | grep active | grep -v systemd | grep -v exited | awk '{ print \$1 }'"
