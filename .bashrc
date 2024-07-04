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
HISTSIZE=100000

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
alias ll='ls -alFh --group-directories-first'
alias la='ls -Ah'
alias l='ls -CFh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias xcc='xclip -selection clipboard'
alias bc='bc -l'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
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

if [ -n "$ZED_TERM" ]; then
    export GIT_EDITOR='zed --wait'
fi

# function set_win_title(){
#     echo -ne "\033]0; ${PWD//$HOME/\~} \007"
# }
function set_win_title() {
    local cmd=" ($@)"
    if [[ "$cmd" == " (starship_precmd)" || "$cmd" == " ()" ]]
    then
      cmd=""
    fi
    if [[ $PWD == $HOME ]]
    then
      if [[ $SSH_TTY ]]
      then
        echo -ne "\033]0; 🏛️ @ $HOSTNAME ~$cmd\a" < /dev/null
      else
        echo -ne "\033]0; 🏠 ~$cmd\a" < /dev/null
      fi
    else
      BASEPWD=$(basename "$PWD")
      if [[ $SSH_TTY ]]
      then
        echo -ne "\033]0; 🌩️ $BASEPWD @ $HOSTNAME $cmd\a" < /dev/null
      else
        echo -ne "\033]0; 📁 $BASEPWD $cmd\a" < /dev/null
      fi
    fi
}
STARSHIP_BIN=/usr/local/bin/starship
[ -x "$STARSHIP_BIN" ] || STARSHIP_BIN=$HOME/.cargo/bin/starship
[ -x "$STARSHIP_BIN" ] || STARSHIP_BIN=$HOME/bin/starship
if [ -x "$STARSHIP_BIN" ]; then
    # starship_precmd_user_func="set_win_title"
    eval "$($STARSHIP_BIN init bash)"
    # trap "set_win_title \${BASH_COMMAND}" DEBUG
fi

vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Debian Packaging Guide
# https://www.debian.org/doc/manuals/debmake-doc/ch03.en.html
quilt_completions=/usr/share/bash-completion/completions/quilt
if [ -f $quilt_completions ]; then
    alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
    source $quilt_completions
    complete -F _quilt_completion $_quilt_complete_opt dquilt
fi
