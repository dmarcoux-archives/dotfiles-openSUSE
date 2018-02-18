#!/usr/bin/env bash

# If Docker is installed, set it up
if type docker > /dev/null; then
  alias doc='docker'
  alias doccom='docker-compose'

  # If fzf is installed, setup the following aliases
  if type fzf > /dev/null; then
    # Select a locally available image and run a new container based on it
    alias drunf='docker image ls | fzf --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker run'

    # Tip: The following aliases are even better when fzf is using this as a default option: --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all
    #      We can quickly select one, multiple or all container(s)

    # Select Docker containers and remove them (with its volumes)
    alias drmf='docker ps --all | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker rm --volumes'

    # Select Docker containers and stop them
    alias dstopf='docker ps | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker stop'

    # Select Docker images and remove them
    alias drmif='docker image ls | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty docker rmi --force'
  fi
fi
