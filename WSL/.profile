# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export DEFAULT_DOTFILES_DIR="/home/dotnet/projects/opensource/dotfiles/WSL"

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
if [[ "$(umask)" = "0000" ]]; then
  umask 0022
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
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
    PATH="$HOME/.yarn/bin:$PATH"
fi

# ssh-agent enables ssh-add to remember ssh passphrase
#if [[ -z "$(pidof ssh-agent)" ]]; then
#echo "Starting ssh-agent"
#eval $(ssh-agent -s)
#echo "Use ssh-add to type in your passphrase once"
#fi

# enable passphrase prompt for gpg
export GPG_TTY=$(tty)

## START SET TERMINAL TITLE ###
# https://superuser.com/questions/79972/set-the-title-of-the-terminal-window-to-the-current-directory
# set the title of the terminal tab to the current directory
set_prompt () {
    BASE_PATH="${PWD##*/}"
    echo -ne "\033]0;$BASE_PATH\007"
}

update_terminal_cwd ()
{
    local url_path='';
    {
        local i ch hexch LC_CTYPE=C LC_ALL=;
        for ((i = 0; i < ${#PWD}; ++i))
        do
            ch="${PWD:i:1}";
            if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                url_path+="$ch";
            else
                printf -v hexch "%02X" "'$ch";
                url_path+="%${hexch: -2:2}";
            fi;
        done
    };

    printf '\e]7;%s\a' "file://$HOSTNAME$url_path"
}

set_my_tab () {
   update_terminal_cwd
   set_prompt
}

PROMPT_COMMAND=set_my_tab
### END SET TERMINAL TITLE ###

# Install Ruby Gems to ~/gems
if [ -f "$HOME/gems" ]; then
    export GEM_HOME="$HOME/gems"
    export PATH="$HOME/gems/bin:$PATH"
fi

# enable nvm for loading different versions of nodejs
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# setup git format in terminal
if [ -f ~/.bash_gitps1 ]; then
  source ~/.bash_gitps1;
fi

# set PATH to WASM tools
if [ -d "$HOME/projects/playground/wabt/build" ] ; then
    PATH="$HOME/projects/playground/wabt/build:$PATH"
fi

# set PATH yarn global installed executables
export PATH="$PATH:`yarn --offline global bin`"

if [ -d "$HOME/perl5" ]; then
    PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
    PERL5LIB="/home/dotnet/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
    PERL_LOCAL_LIB_ROOT="/home/dotnet/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
    PERL_MB_OPT="--install_base \"/home/dotnet/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/home/dotnet/perl5"; export PERL_MM_OPT;
fi

export PATH="$HOME/.cargo/bin:$PATH"

# Start Docker daemon automatically when logging in if not running.
# https://blog.nillsf.com/index.php/2020/06/29/how-to-automatically-start-the-docker-daemon-on-wsl2/
RUNNING=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING" ]; then
    sudo dockerd > /dev/null 2>&1 &
    disown
fi

# Open new terminal tab in same directory as existing tab (WSL)
# https://github.com/microsoft/terminal/issues/3158
# https://unix.stackexchange.com/q/32508/34980

# Show formatted markdown in less
# https://stackoverflow.com/q/15496865/205696
export LESSOPEN=".lessopen.sh %s"
export LESSCLOSE=".lessclose.sh %s %s"
