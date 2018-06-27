# If osc is installed, set it up
if type osc > /dev/null 2>&1; then
  # Mark file(s) to be added upon next commit
  ealias oa='osc add'

  # Mark {new,deleted} local files to be {added,deleted}
  ealias oar='osc addremove'

  # Select one of the configured repositories for the project and build the project for it
  ealias obf='osc repos | fzf | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty osc build --target='

  # Build the project for Leap 15.0
  ealias obl='osc build --target=openSUSE_Leap_15.0/x86_64'

  # Build the project for Tumbleweed
  ealias obt='osc build --target=openSUSE_Tumbleweed/x86_64'

  # Push changes to remote
  ealias oci='osc ci'

  # Check out content from the repository
  ealias oco='osc checkout'

  # Download files referenced via source URL in the project's spec file
  ealias odl='osc service localrun download_files'

  # Create a new package
  ealias omp='osc mkpac'

  # Mark file(s) to be deleted upon next commit
  ealias orm='osc rm'

  # Submit request to a project
  ealias osr='osc submitrequest'
  # TODO: Snippet to submit request to openSUSE:Factory 'osr devel:project:abc/the_package openSUSE:Factory'

  # Show status of files
  ealias ost='osc st'

  # Edit the changes file
  ealias ovc='osc vc'
fi
