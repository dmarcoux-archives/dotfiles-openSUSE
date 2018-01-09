# ag doesn't have a way to set default options, so they are set in the alias below...
# hidden: search hidden files (it obeys ignored files)
# color-match: bold blue foreground
# color-path: bold dark grey foreground
# color-line-number: bold dark grey foreground
alias ag='ag --hidden --color-match="1;38;5;4" --color-path="1;38;5;10" --color-line-number="1;38;5;10"'
