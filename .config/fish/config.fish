if status is-interactive
    alias ll="eza --long --icons --hyperlink"
    alias ls="eza"

    # Emacs and other editors cannot pass `ctrl-shift-z` to fish,
    # so we pass `alt-z` instead and bind it here
    bind alt-z redo

    # wezterm + fish produces ctrl-h instead of ctrl-backspace
    bind ctrl-h backward-kill-word
end
