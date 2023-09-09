# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# enable verbose mode for debugging
# set -v
# enable trace mode for debugging
# set -x
# stop executing to pin-point buggy execution in bash scripts
# kill -SIGINT $$

export DEFAULT_DOTFILES_DIR="/home/dotnet/projects/opensource/dotfiles/WSL"

# Set the DISPLAY environment variable on Linux to use the Windows host's IP
# address as WSL2 and the Windows host are not in the same network device.
# It is necessary to set the DISPLAY environment variable with the correct IP address on launch.
#export DISPLAY="`sed -n 's/nameserver //p' /etc/resolv.conf`:0"

# use wslu to open Windows browser from linux
# https://superuser.com/a/1368878/279100
# Leaving this out will set the browser to the default ELinks
export BROWSER=wslview

# Set terminal title to current directory
# This is a much shorter version of the set_my_tab function in .profile
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# NOT WORKING!
# set new tabs in WSL to open in current path
# https://github.com/microsoft/terminal/issues/3158#issuecomment-803502834
#export PROMPT_COMMAND='printf "\e]9;9;%s\e\\" "$(wslpath -m "$PWD")"'
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'

# set firefund as the default team with heroku CLI.
export HEROKU_ORGANIZATION=firefund

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
if [[ "$(umask)" = "0000" ]]; then
  umask 0022
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes yarn global bin if it exists
if [ -d "$HOME/.yarn/bin" ]; then
    PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
       . "$HOME/.bashrc"
    fi
fi


# ssh-agent enables ssh-add to remember ssh passphrase
#if [[ -z "$(pidof ssh-agent)" ]]; then
#echo "Starting ssh-agent"
#eval $(ssh-agent -s)
#echo "Use ssh-add to type in your passphrase once"
#fi


# enable passphrase prompt for gpg
export GPG_TTY=$(tty)


# Install Ruby Gems to ~/gems
if [ -f "$HOME/gems" ]; then
    export GEM_HOME="$HOME/gems"
    export PATH="$HOME/gems/bin:$PATH"
fi

# enable nvm for loading different versions of nodejs
# commented out because I now use n
#if [ -d "$HOME/.nvm" ]; then
#    export NVM_DIR="$HOME/.nvm"
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#fi

# setup git format in terminal
if [ -f ~/.bash_gitps1 ]; then
  source ~/.bash_gitps1;
fi


# set PATH to WASM tools
if [ -d "$HOME/projects/playground/wabt/build" ] ; then
    PATH="$HOME/projects/playground/wabt/build:$PATH"
fi

if [ -d "$HOME/perl5" ]; then
    PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
    PERL5LIB="/home/dotnet/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
    PERL_LOCAL_LIB_ROOT="/home/dotnet/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
    PERL_MB_OPT="--install_base \"/home/dotnet/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/home/dotnet/perl5"; export PERL_MM_OPT;
fi


export PATH="$HOME/.cargo/bin:$PATH"

# DISABLED BECAUSE OF ANNOYING SUDO PASSWORD WHEN OPENING A NEW TERMINAL!
# *STARTING DOCKER DESKTOP SEEMS TO START THE DOCKER DEAMON ANYWAY*
# Start Docker daemon automatically when logging in if not running.
# https://blog.nillsf.com/index.php/2020/06/29/how-to-automatically-start-the-docker-daemon-on-wsl2/
#RUNNING=`ps aux | grep dockerd | grep -v grep`
#if [ -z "$RUNNING" ]; then
#    sudo dockerd > /dev/null 2>&1 &
#    disown
#fi

# Open new terminal tab in same directory as existing tab (WSL)
# https://github.com/microsoft/terminal/issues/3158
# https://unix.stackexchange.com/q/32508/34980

# Show formatted markdown in less
# https://stackoverflow.com/q/15496865/205696
export LESSOPEN=".lessopen.sh %s"
export LESSCLOSE=".lessclose.sh %s %s"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/home/dotnet/.cache/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
