#! /usr/bin/env sh

set -e

mkdir -p $HOME/bin;

rm -f $HOME/.bashrc
for each in $(find bin/ -mindepth 1 | egrep -v '#$|~$') $( ls -a1 | egrep -v '(^AstoNvim$|^install.sh$|^bin$|\.git$|\.gitignore$|\.gitmodules|^\.\.?$|\~$|#$)'); do
    [ -e $HOME/$each ] || ln -nfs `pwd`/$each $HOME/$each;
done

# astro_nvim_user_dir=$HOME/.config/nvim/lua/user
# [ -e $HOME/.config/nvim ] || ln -nfs `pwd`/AstroNvim $HOME/.config/nvim
# [ -e $astro_nvim_user_dir ] || mkdir -p $astro_nvim_user_dir && ln -nfs `pwd`/.nvim-astro $astro_nvim_user_dir

if grep -v starship $HOME/.profile; then
    curl -sS https://starship.rs/install.sh > $HOME/bin/install-starship.sh
    chmod +x $HOME/bin/install-starship.sh
    $HOME/bin/install-starship.sh -b $HOME/bin --yes
    rm $HOME/bin/install-starship.sh
    echo 'eval "$(starship init bash)"' >> $HOME/.profile
fi
