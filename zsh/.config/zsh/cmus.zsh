# If cmus is installed, set it up
if type cmus > /dev/null 2>&1; then
  # Until the following issue is resolved, this will do
  # https://github.com/cmus/cmus/issues/233
  function cmus-refresh-library() {
    cmus-remote --clear --library
    cmus-remote --library ~/Music
    cmus-remote --raw save
  }
fi
