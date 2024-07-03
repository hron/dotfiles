#! /bin/sh

set -x -e

gsettings set org.gnome.desktop.wm.keybindings show-desktop ['<Primary><Super>d', '<Primary><Alt>d']

gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-1 "['<Super>1', '<Super>x']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-2 "['<Super>2', '<Super>c']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-3 "['<Super>3', '<Super>v']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 "['<Super>4', '<Super>s']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-5 "['<Super>5', '<Super>d']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-6 "['<Super>6', '<Super>f']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-7 "['<Super>7', '<Super>w']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-8 "['<Super>8', '<Super>e']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-9 "['<Super>9', '<Super>r']"

gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-1 "['<Ctrl><Super>1', '<Ctrl><Super>x']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-2 "['<Ctrl><Super>2', '<Ctrl><Super>c']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-3 "['<Ctrl><Super>3', '<Ctrl><Super>v']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-4 "['<Ctrl><Super>4', '<Ctrl><Super>s']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-5 "['<Ctrl><Super>5', '<Ctrl><Super>d']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-6 "['<Ctrl><Super>6', '<Ctrl><Super>f']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-7 "['<Ctrl><Super>7', '<Ctrl><Super>w']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-8 "['<Ctrl><Super>8', '<Ctrl><Super>e']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-9 "['<Ctrl><Super>9', '<Ctrl><Super>r']"

gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-1 "['<Shift><Super>1', '<Shift><Super>x']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-2 "['<Shift><Super>2', '<Shift><Super>c']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-3 "['<Shift><Super>3', '<Shift><Super>v']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-4 "['<Shift><Super>4', '<Shift><Super>s']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-5 "['<Shift><Super>5', '<Shift><Super>d']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-6 "['<Shift><Super>6', '<Shift><Super>f']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-7 "['<Shift><Super>7', '<Shift><Super>w']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-8 "['<Shift><Super>8', '<Shift><Super>e']"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-9 "['<Shift><Super>9', '<Shift><Super>r']"
