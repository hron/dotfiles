# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

STARSHIP_BIN=$HOME/.cargo/bin/starship
[ -x "$STARSHIP_BIN" ] && eval "$($STARSHIP_BIN init bash)"

# Write/read history after each command
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias xcc='xclip -selection clipboard'

# Antti Seppälä: to help with logging in and setting the role I've set up these aliases:
alias aws-xdr-ci-data-admin='samlauth.py --accountid 286741534858 --rolename aws-rds-ci-raw-data-admin --profile xdr-ci-data-admin; export AWS_DEFAULT_PROFILE=xdr-ci-data-admin; export AWS_PROFILE=xdr-ci-data-admin'
alias aws-xdr-stg-data-admin='samlauth.py --accountid 755737209292 --rolename aws-rds-stg-raw-data-admin --profile xdr-stg-data-admin; export AWS_DEFAULT_PROFILE=xdr-stg-data-admin; export AWS_PROFILE=xdr-stg-data-admin'
alias aws-xdr-prd-data-admin='samlauth.py --accountid 977557471879 --rolename aws-rds-prd-raw-data-admin --profile xdr-prd-data-admin; export AWS_DEFAULT_PROFILE=xdr-prd-data-admin; export AWS_PROFILE=xdr-prd-data-admin'

function f_secure_aws_activate() {
  TEAM=$1
  ENV=$2

  if [ -z $TEAM ] || [ -z $ENV ]; then
    echo "You have to profive at least 2 arguments"
    return
  fi

  if [ ! -z $3 ]; then
    POSTFIX="-${3}"
  else
    POSTFIX=""
  fi
  pyenv activate virtenv-3.7.7-aws &&
    aws-login -a $ENV -t $TEAM -P &&
    export AWS_DEFAULT_PROFILE=rds-$TEAM-${ENV}${POSTFIX} &&
    export AWS_PROFILE=$AWS_DEFAULT_PROFILE
}
# alias aws-rds-ci-pua='pyenv activate virtenv-3.7.7-aws && aws-login -a ci -t be -P && export AWS_DEFAULT_PROFILE=rds-be-ci-pua && export AWS_PROFILE=rds-be-ci-pua'
# alias aws-rds-stg-pua='aws-login -a stg -t be -P; export AWS_DEFAULT_PROFILE=rds-be-stg-pua; export AWS_PROFILE=rds-be-stg-pua'
# alias aws-rds-prd-pua='aws-login -a prd -t be -P; export AWS_DEFAULT_PROFILE=rds-be-prd-pua; export AWS_PROFILE=rds-be-prd-pua'
alias aws-rds-ci-pua='f_secure_aws_activate be ci pua'
alias aws-rds-stg-pua='f_secure_aws_activate be stg pua'
alias aws-rds-prd-pua='f_secure_aws_activate be prd pua'

# alias aws-rds-ci='pyenv activate virtenv-3.7.7-aws; aws-login -a ci -t be; export AWS_DEFAULT_PROFILE=rds-be-ci; export AWS_PROFILE=rds-be-ci'
# alias aws-rds-stg='aws-login -a stg -t be; export AWS_DEFAULT_PROFILE=rds-be-stg; export AWS_PROFILE=rds-be-stg'
# alias aws-rds-prd='aws-login -a prd -t be; export AWS_DEFAULT_PROFILE=rds-be-prd; export AWS_PROFILE=rds-be-prd'
alias aws-rds-ci='f_secure_aws_activate be ci'
alias aws-rds-stg='f_secure_aws_activate be stg'
alias aws-rds-prd='f_secure_aws_activate be prd'

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && [[ -z "$INSIDE_EMACS" ]] && exec tmux
