set -l WHITE_THEME_NAME
set -l COLOR_SCHEME (qdbus org.freedesktop.portal.Desktop /org/freedesktop/portal/desktop org.freedesktop.portal.Settings.Read org.freedesktop.appearance color-scheme)

if test $COLOR_SCHEME != 1
    fish_config theme choose default-rgb --color-theme=light
else
    fish_config theme choose default-rgb --color-theme=dark
end
