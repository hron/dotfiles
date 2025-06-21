set -gx BROWSER firefox
set -gx EDITOR 'emacsclient -a "emacs" -c'
#set -gx ALTERNATE_EDITOR ""
set -gx DEBEMAIL "aleksei.gusev@gmail.com"
set -gx DEBFULLNAME "Aleksei Gusev"
# set -gx QT_SCALE_FACTOR 1.25
set -gx PGHOST localhost
set -gx PGUSER spaceship
set -gx PGDATABASE spaceship
set -gx QT_QPA_PLATFORMTHEME gnome

if status is-interactive
    alias ll="eza --long --icons --hyperlink"
    alias ls="eza"

    # Emacs and other editors cannot pass `ctrl-shift-z` to fish,
    # so we pass `alt-z` instead and bind it here
    bind alt-z redo

    # wezterm + fish produces ctrl-h instead of ctrl-backspace
    bind ctrl-h backward-kill-word
end
