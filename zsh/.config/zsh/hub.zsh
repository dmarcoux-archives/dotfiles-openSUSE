# If hub is installed, set it up
if type hub > /dev/null 2>&1; then
  #   Pass GITHUB_TOKEN with personal access token to avoid storing GitHub credentials ('man hub' for details)
  #   Generate a personal access token at https://github.com/settings/tokens/new
  alias hub='GITHUB_TOKEN="$(pass pass/me/hub-cli-github-access-token)" hub'

  # Create a new GitHub repository
  alias hubc='hub create'

  GITHUB_USER="dmarcoux"

  # Fork a Git repository. It clones the repository, creates the fork on GitHub and sets remotes
  fork_repo() {
    if [ -z "$1" ]; then
      # Display usage
      echo "Usage: ${funcstack[1]} git@github.com:username/repo.git"
      return
    fi

    REPOSITORY_URL="$1"
    REPOSITORY_NAME="$(basename "$1" .git)"

    # Clone repository
    git clone "$REPOSITORY_URL"

    # Go into cloned repository and fork it
    (
      cd "$REPOSITORY_NAME" || exit

      # Pass GITHUB_TOKEN with personal access token to avoid storing GitHub credentials ('man hub' for details)
      # Generate a personal access token at https://github.com/settings/tokens/new
      GITHUB_TOKEN="$(pass pass/me/hub-cli-github-access-token)" hub fork

      # Rename remotes created by hub
      # - origin (repository) is renamed to upstream
      # - my_user_name (fork) is renamed to origin
      git remote rename origin upstream
      git remote rename "$GITHUB_USER" origin
    )
  }

  # Setup a Git repository for an existing fork. It clones the repository, sets the remotes and HEADs for upstream and the fork.
  setup_existing_fork() {
    if [ -z "$1" ]; then
      # Display usage
      echo "Usage: ${funcstack[1]} git@github.com:username/upsteam_repo.git"
      return
    fi

    UPSTREAM="$1"
    # replace whatever is between : and / in $UPSTREAM by $GITHUB_USER
    FORK="$(sed "s|:.*/|:$GITHUB_USER/|g" <<<"$UPSTREAM")"
    REPOSITORY_NAME="$(basename "$1" .git)"

    # Clone repository
    git clone "$UPSTREAM"

    # Go into cloned repository and set the remotes and HEADs
    (
      cd "$REPOSITORY_NAME" || exit

      git remote add upstream "$UPSTREAM"
      git fetch --tags upstream
      git remote set-head upstream master

      git remote set-url origin "$FORK"
      git fetch --tags origin
      git remote set-head origin master
    )
  }

  # Update fork of a Git repository (it has to be setup with fork_repo to follow the remote naming convention)
  update_fork() {
    # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
    DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/upstream/HEAD | sed 's\^refs/remotes/upstream/\\')"

    # Checkout the default branch
    git checkout "$DEFAULT_BRANCH"

    # Rebase the default branch on the upstream changes
    git pull --rebase --autostash upstream "$DEFAULT_BRANCH"

    # Push updated default branch to my fork
    git push origin "$DEFAULT_BRANCH"

    git submodule update
  }

  # Checkout branch of someone else's fork
  checkout_fork() {
    if [ -z "$1" ]; then
      # Display usage
      echo "Usage: ${funcstack[1]} username:branch"
      return
    fi

    USER="$(echo "$1" | cut --delimiter=':' --fields=1)"
    BRANCH="$(echo "$1" | cut --delimiter=':' --fields=2)"
    REMOTE="$(git config remote.origin.url | sed -e "s|:.*/|:$USER/|g")"

    # Add a remote for the fork (if one with the same name doesn't already exist)
    if ! git remote get-url "$USER" > /dev/null 2>&1; then
      git remote add "$USER" "$REMOTE"
    fi

    # Fetch branches of the fork
    git fetch --tags "$USER"

    # Checkout the fork's branch
    git checkout "$USER"/"$BRANCH"

    # Create a local copy of the fork's branch
    git checkout -b "$BRANCH"
  }
fi
