#!/usr/bin/env bash

DIRECTORY="$HOME/.wine/win32/GuildWars"

# If the wineprefix for $DIRECTORY is not present, create it
if [ ! -d "$DIRECTORY" ]; then
  mkdir --parents "$DIRECTORY"

  WINEARCH=win32 WINEPREFIX="$DIRECTORY" winetricks corefonts d3dx9
fi

# Install Lutris if it's not already
if ! type lutris > /dev/null 2>&1; then
  sudo zypper install --details lutris
fi

# If Guild Wars is not installed, install it
# TODO: Automate selection of folder to $DIRECTORY
if lutris --list-games | grep guild-wars; then
  lutris lutris:install/guild-wars
fi

# TODO: Automate this...
# Uncheck 'Prefer system libraries' in Lutris' preferences
