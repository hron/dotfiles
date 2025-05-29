if [ -n "$TMUX" ] && string match -q -r "screen|tmux" "$TERM"
    # Directory tracking and Prompt tracking
    function tmux_prompt_end
        printf "\033]133;A\033\\"
    end
    functions --copy fish_prompt tmux_old_fish_prompt
    function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
        # Remove the trailing newline from the original prompt. This is done
        # using the string builtin from fish, but to make sure any escape codes
        # are correctly interpreted, use %b for printf.
        printf "%b" (string join "\n" (tmux_old_fish_prompt))
        tmux_prompt_end
    end
    # tmux + fish produces ctrl-h instead of ctrl-backspace
    bind ctrl-h backward-kill-word
end
