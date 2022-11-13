# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export BROWSER=sensible-browser
export EDITOR='/usr/bin/emacsclient -c'
export ALTERNATE_EDITOR=""
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

if [ -d "$HOME/.yarn/bin" ] ; then
    PATH="$HOME/.yarn/bin:$PATH"
fi

# asdf
if [ -f $HOME/.asdf/asdf.sh ]; then
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash
fi


export ADVTP_BUILD_DIR=$HOME/src/f-secure/advtp-build

# https://stash.f-secure.com/projects/ADVTP/repos/advtp-aws-deployment/browse/
export ADVTP_AWS_DEPLOYMENT_DIR="$HOME/src/f-secure/advtp-aws-deployment"
if [ -d $ADVTP_AWS_DEPLOYMENT_DIR ]; then
    PATH="$ADVTP_AWS_DEPLOYMENT_DIR/bin:$PATH"
    source $ADVTP_AWS_DEPLOYMENT_DIR/bin/awsenvtool
fi

# Homebrew
homebrew_exe=/home/linuxbrew/.linuxbrew/bin/brew
if [ -x ${homebrew_exe} ]; then
    eval $(${homebrew_exe} shellenv)
fi

# Rust
rust_env="$HOME/.cargo/env"
if [ -f $rust_env ]; then
   . $rust_env
fi

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# https://direnv.net/docs/hook.html
if [ -x /usr/bin/direnv ]; then
    eval "$(direnv hook bash)"
fi
