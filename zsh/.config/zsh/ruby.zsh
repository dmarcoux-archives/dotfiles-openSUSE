# If rbenv is installed, set it up
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"

  # TODO: Make sure rbenv is not using the system ruby
  # Install rubocop if not already installed
  if ! type rubocop > /dev/null 2>&1; then
    # TODO: Update this automatically with a PR in my dotfiles' repository when the following file changes:
    #       Look into using hub (https://hub.github.com/) to create the PR from the command line after changing the files
    # https://github.com/bbatsov/rubocop/blob/master/lib/rubocop/version.rb
    gem install --no-document rubocop --version 0.54.0
  fi

  ealias rubocop='rubocop --parallel'
fi
