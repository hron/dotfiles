#!/bin/bash
changed_files=()

for filename in $HOME/.local/share/applications/*.desktop; do
    printf "\n\n$filename\n"
    steam_icon_line=$(cat "$filename" | grep "Icon=steam_icon")

    if [[ -z "$steam_icon_line" ]]
    then
        printf "not a steam shortcut, skipping..."
        continue
    fi

    IFS='_'
    read -ra steam_icon_array <<< "$steam_icon_line"
    steam_id=${steam_icon_array[2]}

    new_wmclass_line=$(printf "StartupWMClass=steam_app_${steam_id}")

    if [[ ! -z $(cat "$filename" | grep "$new_wmclass_line") ]]
    then
        printf "already has StartupWMClass, no changes needed..."
        continue
    fi

    printf "adding \"$new_wmclass_line\" to end of file..."
    printf "\n$new_wmclass_line" >> $filename
    changed_files+=("$filename")
done

printf "\n\n\nAdded StartupWMClass to files:\n"
printf "%s\n" "${changed_files[@]}"

update-desktop-database -v $HOME/.local/share/applications/
