#!/usr/bin/env bash

# --data '{"abc":"123","def":"'my text'"}' or --data @filename (for some file containing JSON)
alias curljson='curl --verbose --header "Content-Type: application/json" --data' # See above for --data, then add  http://whatever.com
