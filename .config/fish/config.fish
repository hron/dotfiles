if status is-interactive

    alias ll="eza --long --icons --hyperlink"
    alias ls="eza"

    starship init fish | source

    # vterm integration
    if [ "$INSIDE_EMACS" = vterm ]
        function vterm_printf
            if begin
                    [ -n "$TMUX" ]; and string match -q -r "screen|tmux" "$TERM"
                end
                # tell tmux to pass the escape sequences through
                printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
            else if string match -q -- "screen*" "$TERM"
                # GNU screen (screen, screen-256color, screen-256color-bce)
                printf "\eP\e]%s\007\e\\" "$argv"
            else
                printf "\e]%s\e\\" "$argv"
            end
        end

        function clear
            vterm_printf "51;Evterm-clear-scrollback"
            tput clear
        end

        # Directory tracking and Prompt tracking
        function vterm_prompt_end
            vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
        end
        functions --copy fish_prompt vterm_old_fish_prompt
        function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
            # Remove the trailing newline from the original prompt. This is done
            # using the string builtin from fish, but to make sure any escape codes
            # are correctly interpreted, use %b for printf.
            printf "%b" (string join "\n" (vterm_old_fish_prompt))
            vterm_prompt_end
        end

        #  not in Emacs, so setup tmux integration
    else if begin
            [ -n "$TMUX" ]; and string match -q -r "screen|tmux" "$TERM"
        end
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
end
