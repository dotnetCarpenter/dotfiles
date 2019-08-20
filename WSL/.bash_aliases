#!/usr/bin/env bash

alias cls=clear

#alias clip="xclip -selection clipboard"
alias clip="clip.exe"

# alias for watch so watch can watch aliases
alias watch='watch '

# get octal file permissions for a file
# https://www.cyberciti.biz/faq/get-octal-file-permissions-from-command-line-on-linuxunix/
alias ostat='stat -c '%a' '

# setup transmission shortcuts
if [ -f "$DEFAULT_DOTFILES_DIR/../transmission/.transmission_aliases" ]; then
  source "$DEFAULT_DOTFILES_DIR/../transmission/.transmission_aliases";
fi