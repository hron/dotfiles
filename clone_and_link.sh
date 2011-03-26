#! /bin/bash

mkdir $HOME/src && cd $HOME/src &&
git clone git://github.com/hron/dotfiles &&
cd $HOME/src/dotfiles && make
