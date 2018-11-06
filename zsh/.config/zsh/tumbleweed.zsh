ealias t='tumbleweed'
ealias tst='tumbleweed status'
ealias tsw='tumbleweed switch'
# This is different from `tumbleweed update` since it displays the details when updating
ealias tup='tumbleweed switch && sudo zypper dup --details'
# List available Tumbleweed snapshots, mark the current one with `(current)` and select one with fzf before switching to it
# TODO: Highlight the current version instead of using text for that purpose. I need to figure out color codes...
# TODO: It ask for root password on the same line as the message from tumbleweed-cli (it's weird, even though it still works)
ealias tf='tumbleweed list | sed "s/$(tumbleweed version)/& (current)/" | fzf --header="Available Tumbleweed snapshots" | xargs --no-run-if-empty tumbleweed switch '
