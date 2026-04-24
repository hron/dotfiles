if status is-interactive
    alias ll="eza -ahl --group-directories-first --icons --hyperlink"
    alias ls="eza -ah --group-directories-first"
    alias cat=bat

    # Emacs and other editors cannot pass `ctrl-shift-z` to fish,
    # so we pass `alt-z` instead and bind it here
    bind alt-z redo

    bind alt-/ end-of-line

    bind alt-backspace backward-kill-word
end

function fish_title
    # If a command is running, show "command @ folder"
    # If idle, just show "folder"
    set -l current_cmd (set -q argv[1]; and echo "$argv[1] @ "; or echo "")
    echo $current_cmd(prompt_pwd)
end
