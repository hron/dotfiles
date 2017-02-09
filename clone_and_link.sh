#! /bin/bash

# [[ -d $HOME/src ]] || mkdir $HOME/src && cd $HOME/src &&
# git clone git://github.com/hron/dotfiles &&
# cd $HOME/src/dotfiles && make

cd &&
 [ -d '.dot-files' ] || git clone git://github.com/hron/dotfiles .dot-files &&
 cd .dot-files &&
 mkdir $HOME/bin || true;
 for each in $(find bin/ -mindepth 1 | egrep -v '#$|~$') $( ls -a1 | egrep -v '(^clone_and_link.sh$|^bin$|^Makefile$|\.git$|\.gitignore$|\.gitmodules|^\.\.?$|\~$|#$)'); do
     [ -e $HOME/$each ] || ln -nfs `pwd`/$each $HOME/$each;
 done
