# Quicker than cd ..; cd ...; etc...
#   ~$ cd ~/dir/example/folder
#   ~/dir/example/folder$ up 2
#   ~/dir$
# Credits: http://www.bashoneliners.com/oneliners/oneliner/220/ (I simply reformated the script)
up() {
  # Defaults to 1 when no depth is provided
  DEPTH=${1-1};

  for i in $(seq 1 ${DEPTH}); do
    cd ../
  done
}

upc() {
  if [ -z "$*" ]; then
    # Display usage if no parameters given
    echo "Usage: upc <directory_name> OR upc <number of directories up> <directory_name>"
    return
  fi

  # TODO: Complete!!!
  # upc X my_dir
  # Goes X directories up, then cd into directory (if found, otherwise list directories with fzf to select one)

  # upc my_dir
  # Goes one directory up, then cd into directory (if found, otherwise list directories with fzf to select on
}

# Extract archives
extract() {
  if [ -z "$1" ]; then
    # Display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    return
  fi

  for file in "$@"
  do
    if [ -f "$file" ]; then
      NAME=${file%.*}
      mkdir $NAME && cd $NAME
      case $file in
        *.tar.bz2)   tar xvjf ../$file     ;;
        *.tar.gz)    tar xvzf ../$file     ;;
        *.tar.xz)    tar xvJf ../$file     ;;
        *.lzma)      unlzma ../$file       ;;
        *.bz2)       bunzip2 ../$file      ;;
        *.rar)       unrar x -ad ../$file  ;;
        *.gz)        gunzip ../$file       ;;
        *.tar)       tar xvf ../$file      ;;
        *.tbz2)      tar xvjf ../$file     ;;
        *.tgz)       tar xvzf ../$file     ;;
        *.zip)       unzip ../$file        ;;
        *.Z)         uncompress ../$file   ;;
        *.7z)        7z x ../$file         ;;
        *.xz)        unxz ../$file         ;;
        *.exe)       cabextract ../$file   ;;
        *)           echo "extract: '$file ' - unknown archive method" ;;
      esac

      cd ..
    else
      echo "$file  - file does not exist"
    fi
  done
}

# Export environment variables from a file (by default .env, but can be passed as an argument)
exportenv() {
  FILE=${1-.env}

  if [ ! -f "$FILE" ]; then
    echo "File $FILE not found"
    return
  fi

  # Read $FILE, remove all commments and empty lines
  VARS="$(cat $FILE | sed -e '/^[[:space:]]*$/d;/^#/d')"

  if [ -z "$VARS" ]; then
    echo "Nothing to export in the file $FILE"
    return
  fi

  echo 'Exporting the environment variables:'
  echo $VARS

  export $(echo $VARS | xargs)
}

# Read from STDIN and return matched text
#
# $1: regular expression pattern
#
# Example: ip link show | sedp 'wlp[0-9]s[0-9]'
sedp() {
  sed -n "s/^.*\($1\).*$/\1/p"
}
