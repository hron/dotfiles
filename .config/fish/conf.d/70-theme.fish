fish_config theme choose default-rgb

function handle_theme_change --on-signal USR1
    if test "$fish_terminal_color_theme" = dark
        set -gx fish_terminal_color_theme light
    else
        set -gx fish_terminal_color_theme dark
    end
end
