#!/usr/bin/env bash
# Monitor the battery if needed

# Details at https://superuser.com/questions/877677/programatically-determine-if-an-script-is-being-executed-on-laptop-or-desktop
CHASSIS_TYPE="$(cat /sys/class/dmi/id/chassis_type)"

case $CHASSIS_TYPE in
  # Portable, Laptop, Notebook or Sub Notebook
  8|9|10|14)
    # Launch battery monitor
    cbatticon
    ;;
  *)
    exit 1
esac
