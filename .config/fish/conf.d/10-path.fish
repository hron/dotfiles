if status is-login
    for path in $HOME/.cargo/bin $HOME/.npm-global/bin $HOME/bin $HOME/.local/bin
        if test -d $path
            fish_add_path --path $path
        end
    end
end
