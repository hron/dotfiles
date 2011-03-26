#! /bin/bash

# [[ -d $HOME/src ]] || mkdir $HOME/src && cd $HOME/src &&
# git clone git://github.com/hron/dotfiles &&
# cd $HOME/src/dotfiles && make

cd &&
 [ -d '.dot-files' ] || git clone git://github.com/hron/dotfiles .dot-files &&
 cd .dot-files && make
