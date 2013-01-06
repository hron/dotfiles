export PATH=$HOME/bin:$PATH:/sbin:/usr/sbin:
export EDITOR=emacsclient

export PGHOST=127.0.0.1
export PGUSER=postgres

export HISTFILE=~/.zhistory

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus-qt4

export GPGKEY=7E023519

export EMAIL="aleksei.gusev@gmail.com"

# Chromium dev tools
PATH=$HOME/src/chromium-dev/depot_tools:$PATH

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
PATH=$GEM_HOME/bin:$PATH
