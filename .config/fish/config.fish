if status is-interactive
    alias ll="eza -ahl --group-directories-first --icons --hyperlink"
    alias ls="eza -ah --group-directories-first"
    alias cat=bat

    # Emacs and other editors cannot pass `ctrl-shift-z` to fish,
    # so we pass `alt-z` instead and bind it here
    bind alt-z redo

    bind alt-/ end-of-line

    bind ctrl-w backward-kill-word
end
