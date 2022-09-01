#! /usr/bin/env bash

set -e

mkdir -p $HOME/bin;

rm $HOME/.bashrc
for each in $(find bin/ -mindepth 1 | egrep -v '#$|~$') $( ls -a1 | egrep -v '(^install.sh$|^bin$|\.git$|\.gitignore$|\.gitmodules|^\.\.?$|\~$|#$)'); do
    [ -e $HOME/$each ] || ln -nfs `pwd`/$each $HOME/$each;
done

curl -sS https://starship.rs/install.sh > $HOME/bin/install-starship.sh
chmod +x $HOME/bin/install-starship.sh
$HOME/bin/install-starship.sh -b $HOME/bin --yes
rm $HOME/bin/install-starship.sh
echo 'eval "$(starship init bash)"' >> $HOME/.profile
