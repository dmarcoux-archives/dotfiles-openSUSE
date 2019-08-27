#!/usr/bin/env bash

# Disable desktop notifications
kwriteconfig5 --file 'Dharkael/flameshot.ini' --group 'General' --key 'showDesktopNotification' 'false'

# Set path where screenshots are saved
kwriteconfig5 --file 'Dharkael/flameshot.ini' --group 'General' --key 'savePath' '~/Pictures'
