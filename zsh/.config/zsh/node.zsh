# Added by n-install, see http://git.io/n-install-repo
export N_PREFIX="$HOME/n"

[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# If TypeScript compiler is not installed, install it
if ! type tsc > /dev/null 2>&1; then
  npm install -g typescript
fi

# If TypeScript linter is not installed, install it
if ! type tslint > /dev/null 2>&1; then
  npm install -g tslint
fi

# If TypeScript formatter is not installed, install it
if ! type tsfmt > /dev/null 2>&1; then
  npm install -g typescript-formatter
fi

# If tern (editor-independent Javascript analyzer) is not installed, install it
if ! type tern > /dev/null 2>&1; then
  npm install -g tern
fi
