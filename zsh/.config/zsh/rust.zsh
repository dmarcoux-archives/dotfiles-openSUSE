# If cargo is installed, set it up
if type cargo > /dev/null 2>&1; then
  ealias cb='cargo build'
  ealias cr='cargo run'
fi
