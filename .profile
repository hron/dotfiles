# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export BROWSER=sensible-browser
export EDITOR='emacs'
#export ALTERNATE_EDITOR=""

export GTK2_RC_FILES=/home/aleksei/.gtkrc-2.0
export DEBEMAIL="aleksei.gusev@gmail.com"
export DEBFULLNAME="Aleksei Gusev"

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


# Homebrew
homebrew_exe=/home/linuxbrew/.linuxbrew/bin/brew
if [ -x ${homebrew_exe} ]; then
    eval $(${homebrew_exe} shellenv)
fi

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# export QT_SCALE_FACTOR=1.25
export PGHOST=localhost
export PGUSER=spaceship
export PGDATABASE=spaceship

# https://direnv.net/docs/hook.html
# if [ -x /usr/bin/direnv ]; then
#     eval "$(direnv hook bash)"
# fi
