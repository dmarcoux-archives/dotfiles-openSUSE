#!/usr/bin/env bash

# Set Konsole's default profile to SolarizedLight.profile (it should be stowed beforehand)
kwriteconfig5 --file konsolerc --group 'Desktop Entry' --key 'DefaultProfile' 'SolarizedLight.profile'
