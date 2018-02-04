#!/usr/bin/env bash

# Check if screen sleep is turned on/off
xset q | grep 'DPMS is Disabled' &> /dev/null

if [ "$?" -eq "0" ]; then
  # Turn on Energy Star features
  xset +dpms

  # Turn on screen saver
  xset s on

  echo 'Screen sleep on'
else
  # Turn off Energy Star features
  xset -dpms

  # Turn off screen saver
  xset s off

  echo 'Screen sleep off'
fi
