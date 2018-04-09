# If fzf is installed, set it up
if type fzf > /dev/null 2>&1; then
  # Load default config files (completion and key bindings)
  # Completion at https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
  # Key bindings at https://github.com/junegunn/fzf#key-bindings-for-command-line
  for config in /etc/zsh_completion.d/fzf{,-key-bindings}; do source $config; done

  # fzf-marks: https://github.com/urbainvaes/fzf-marks
  # GNU General Public License v3.0
  if [[ -z "${MARKS_FILE}" ]] ; then
    mkdir --parents $MARKS_DIR &> /dev/null 2>&1
  fi

  if [[ ! -f "${MARKS_FILE}" ]]; then
    touch "${MARKS_FILE}"
  fi

  # Create a fzf mark
  function mark() {
    local mark_to_add
    # Replace /home/my_user by ~ (https://unix.stackexchange.com/a/207237)
    mark_to_add=$(echo "$* : ${PWD/#$HOME/~}")
    echo "${mark_to_add}" >> "${MARKS_FILE}"

    echo "** The following mark has been added **"
    echo "${mark_to_add}"
  }

  function handle_symlinks() {
    local fname
    if [ -L "${MARKS_FILE}" ]; then
      fname=$(readlink "${MARKS_FILE}")
    else
      fname=${MARKS_FILE}
    fi
    echo "${fname}"
  }

  # cd to a fzf mark
  # TODO: Fix minor bug which doesn't display VCS info
  # TODO: Fix -> Pressing Enter after is somehow blocking the shell... weird
  function jump() {
    local jumpline jumpdir marks
    jumpline=$(fzf --bind=ctrl-y:accept < "${MARKS_FILE}")
    if [[ -n ${jumpline} ]]; then
      jumpdir=$(echo "${jumpline}" | sed -n "s/.* : \(.*\)$/\1/p" | sed "s#~#${HOME}#")
      marks=$(handle_symlinks)
      cd "${jumpdir}"
    fi
    zle && zle reset-prompt
  }

  # Delete a fzf mark
  function dmark()  {
    local marks_to_delete line marks
    marks_to_delete=$(fzf --multi --bind=ctrl-y:accept,ctrl-t:toggle --tac < "${MARKS_FILE}")
    marks=$(handle_symlinks)

    if [[ -n ${marks_to_delete} ]]; then
      while read -r line; do
        perl -p -i -e "s#${line}\n##g" ${marks}
      done <<< "$marks_to_delete"

      echo "** The following marks have been deleted **"
      echo "${marks_to_delete}"
    fi
  }

  # Define keybind CTRL+G to jump to fzf mark
  zle -N jump
  bindkey '^g' jump
fi
