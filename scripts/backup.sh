#!/usr/bin/env bash
# Backup system under dotfiles/backup/$HOSTNAME/

# -e: Exit on commands not found
# -u: Exit on unset variables
# -x: Write to standard error a trace for each command after it expands the command and before it executes it
set -eux
