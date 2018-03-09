#!/usr/bin/env bash
# Backup system under dotfiles/backup/$HOSTNAME/

# -e: Exit on commands not found
# -u: Exit on unset variables
# -x: Write to standard error a trace for each command after it expands the command and before it executes it
set -eux

mkdir --parents "$HOME/dotfiles/backup/$HOSTNAME"

# Generate sorted list of explicitly installed packages
zypper search --installed-only | tr --delete " " | sed -nr '/^(i\+)/p' | cut --delimiter="|" --fields=2 | sort > "$HOME/dotfiles/backup/$HOSTNAME/packages.txt"
