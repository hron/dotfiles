set -l BTOP_CURRENT_THEME_FILE "$HOME/.config/btop/themes/current.theme"
set -l BTOP_WHITE_THEME_FILE "whiteout.theme"
set -l WHITE_THEME_NAME "ayu Light"

if test -L "$BTOP_CURRENT_THEME_FILE"
    if test (basename (readlink "$BTOP_CURRENT_THEME_FILE")) = "$BTOP_WHITE_THEME_FILE"
        fish_config theme choose "$WHITE_THEME_NAME"
    end
end
