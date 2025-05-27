# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export BROWSER=firefox
export EDITOR='emacsclient -a "emacs" -c'
#export ALTERNATE_EDITOR=""
export DEBEMAIL="aleksei.gusev@gmail.com"
export DEBFULLNAME="Aleksei Gusev"
# export QT_SCALE_FACTOR=1.25
export PGHOST=localhost
export PGUSER=spaceship
export PGDATABASE=spaceship
export QT_QPA_PLATFORMTHEME=gnome

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Nix Standalone
nix_profile=$HOME/.nix-profile/etc/profile.d/nix.sh
[ -e $nix_profile ] && source $nix_profile

# Nix's Home Manager
nix_home_manager_init=$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
[ -e $nix_home_manager_init ] && source $nix_home_manager_init

# Added by Toolbox App
export PATH="$PATH:/home/algus/.local/share/JetBrains/Toolbox/scripts"

# rustup
. "$HOME/.cargo/env"
