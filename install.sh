#! /usr/bin/env sh

set -e


rm -f $HOME/.bashrc $HOME/.config
for each in $(find bin/ -mindepth 1 | egrep -v '#$|~$') $( ls -a1 | egrep -v '(^AstoNvim$|^install.sh$|^bin$|\.git$|\.gitignore$|\.gitmodules|^\.\.?$|\~$|#$)'); do
    [ -e $HOME/$each ] || ln -nfs `pwd`/$each $HOME/$each;
done

curl -sS https://starship.rs/install.sh | sh -s -- --yes
