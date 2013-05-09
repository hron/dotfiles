export PATH=$HOME/bin:$PATH:/sbin:/usr/sbin:
export EDITOR=emacsclient

export PGHOST=127.0.0.1
export PGUSER=postgres

export HISTFILE=~/.zhistory

# export XMODIFIERS=@im=ibus
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus-qt4

export GPGKEY=7E023519

export EMAIL="aleksei.gusev@gmail.com"

ulimit -n 32768

read -r -d '' GUARD_NOTIFICATIONS <<'EOF'
---
- :name: :libnotify
  :options: {}
EOF
export GUARD_NOTIFICATIONS

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
