#! /usr/bin/env bash

set -e

mkdir -p $HOME/bin;

rm $HOME/.bashrc

for each in $(find bin/ -mindepth 1 | egrep -v '#$|~$') $( ls -a1 | egrep -v '(^install.sh$|^bin$|\.git$|\.gitignore$|\.gitmodules|^\.\.?$|\~$|#$)'); do
    [ -e $HOME/$each ] || ln -nfs `pwd`/$each $HOME/$each;
done

