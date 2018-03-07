#!/usr/bin/env bash
# Toggle touchpad and trackpoint on Lenovo Thinkpad 13 2nd Generation

state=$(xinput list-props 'ETPS/2 Elantech Touchpad' | grep 'Device Enabled' | grep -o '[01]$')

if [ "$state" = '1' ]; then
  # xinput disable NAME (NAME is from 'xinput list')
  xinput disable 'ETPS/2 Elantech Touchpad' > /dev/null 2>&1
  xinput disable 'ETPS/2 Elantech TrackPoint' > /dev/null 2>&1
else
  # xinput enable NAME (NAME is from 'xinput list')
  xinput enable 'ETPS/2 Elantech Touchpad' > /dev/null 2>&1
  xinput enable 'ETPS/2 Elantech TrackPoint' > /dev/null 2>&1
fi
