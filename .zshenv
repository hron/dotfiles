# General
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin
# Android SDK
export PATH=$PATH:$HOME/local/android-sdk-linux/tools:$HOME/local/android-sdk-linux/platform-tools
# RVM
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR="emacsclient -c"

export PGHOST=127.0.0.1
export PGUSER=postgres

export HISTFILE=~/.zhistory

# export XMODIFIERS=@im=ibus
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus-qt4

export GPGKEY=7E023519

export EMAIL="aleksei.gusev@gmail.com"

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export NVM_DIR="/home/aleksei/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
