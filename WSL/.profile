# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export DEFAULT_DOTFILES_DIR="/home/dotnet/projects/opensource/dotfiles/WSL"

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

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
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes yarn global bin if it exists
if [ -d "$HOME/.yarn/bin" ] ; then
    PATH="$HOME/.yarn/bin:$PATH"
fi

# ssh-agent enables ssh-add to remember ssh passphrase
if [[ -z "$(pidof ssh-agent)" ]]
then
echo "Starting ssh-agent"
eval $(ssh-agent -s)
echo "Use ssh-add to type in your passphrase once"
fi

# enable passphrase prompt for gpg
export GPG_TTY=$(tty)

## START SET TERMINAL TITLE ###
# https://superuser.com/questions/79972/set-the-title-of-the-terminal-window-to-the-current-directory
# set the title of the terminal tab to the current directory
set_prompt () {
    BASE_PATH="${PWD##*/}"
    echo -ne "\033]0;$BASE_PATH\007"
}

set_my_tab () {
   update_terminal_cwd
   set_prompt
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

PROMPT_COMMAND=set_my_tab
### END SET TERMINAL TITLE ###
