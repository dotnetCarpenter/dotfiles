#!/usr/bin/env bash

alias cls=clear

#alias clip="xclip -selection clipboard"
alias clip="clip.exe"

# alias for watch so watch can watch aliases
alias watch='watch '

# get octal file permissions for a file
# https://www.cyberciti.biz/faq/get-octal-file-permissions-from-command-line-on-linuxunix/
alias ostat='stat -c '%a' '

# git status because I mistype it all the time
alias gitst='git status'

# setup transmission shortcuts
if [ -f "$DEFAULT_DOTFILES_DIR/../transmission/.transmission_aliases" ]; then
  source "$DEFAULT_DOTFILES_DIR/../transmission/.transmission_aliases";
fi

# open folder in Windows Explorer via "open ." e.g. "open path"
open() {
  explorer.exe `wslpath -w "$1"`
}

# starred_search can be install via `yarn global add starred_search
# https://github.com/Link-/starred_search
alias gitstar="starred_search --user 'dotnetcarpenter' --cache-dir '/tmp/.cache' --find"

alias update="sudo apt update && apt list --upgradable"

alias server="python3 -m http.server"

alias darkcss="cat ~/.dark.css"
# https://superuser.com/questions/32355/undo-linuxs-rm
alias rm=trash

# start sublime text from terminal
alias subl='/mnt/c/Program\ Files/Sublime\ Text/subl.exe'

# when you got a loooong commit hash but you want to post the short one...
alias shortcommit="git rev-parse --short $1"
