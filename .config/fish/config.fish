if status is-interactive
    alias ll="eza -ahl --group-directories-first --icons --hyperlink"
    alias ls="eza -ah --group-directories-first"
    alias cat=bat

    # Emacs and other editors cannot pass `ctrl-shift-z` to fish,
    # so we pass `alt-z` instead and bind it here
    bind alt-z redo

    # wezterm + fish produces ctrl-h instead of ctrl-backspace
    bind ctrl-h backward-kill-word

    bind alt-/ end-of-line
end
