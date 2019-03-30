# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

export BROWSER=chromium-browser
export EDITOR=code-insiders
export GTK2_RC_FILES=/home/aleksei/.gtkrc-2.0

function connect_googledrive {
    mountpoint="${HOME}/GoogleDrive"
    if [[ ! "$(ls ${mountpoint})" ]]; then
        printf "mounting google drive: waiting for network connection"
        while ! ping -q -c 1 -W 1 8.8.8.8 > /dev/null 2>&1; do
            printf "..."
            sleep 1
        done
        printf "\n"
        cd "${HOME}"
        google-drive-ocamlfuse "$mountpoint"
    fi
    printf "google drive connected\n"
}
connect_googledrive
