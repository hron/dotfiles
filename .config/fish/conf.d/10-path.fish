if status is-login
    for path in $HOME/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.npm-global/bin
        if test -d $path
            fish_add_path $path
        end
    end
end
