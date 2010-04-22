#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
source /etc/profile

# Search path for the cd command
cdpath=(.. ~ ~/src ~/zsh)

# enable color support of ls and also add handy aliases
eval `dircolors -b`

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias grep='egrep --color=auto'
alias rsync='/usr/bin/rsync -hav --progress'

alias ll='ls -l -h'
alias ls='ls --color=auto'
# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'
# List only file beginning with "."
alias lsa='ls -ld .*'

# gem
alias gi='gem install --verbose'
alias gu='gem uninstall --verbose'
alias gl='gem list'
alias gs='gem search --remote'
alias bi='bundle install'

alias cut='cut -f1 --delimiter=" "'

# Where to look for autoloaded function definitions
#fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
#for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

# manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
# export MANPATH

# Hosts to use for completion (see later zstyle)
#hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
PROMPT='%B%m%b%# '		# default prompt
RPROMPT=' %~'			# prompt for right side of screen

HISTFILE=~/.zhistory
SAVEHIST=1000
HISTSIZE=1000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_NO_FUNCTIONS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

WORDCHARS='*?[]~&;!#$%^(){}<>'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning bashautolist
setopt   histappend
unsetopt bgnice autoparamslash beep automenu

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# Some nice key bindings
bindkey '^X^Z' universal-argument ' ' magic-space
bindkey '^X^A' vi-find-prev-char-skip
bindkey '^Xa' _expand_alias
bindkey '^Z' accept-and-hold
bindkey -s '\M-/' \\\\
bindkey -s '\M-=' \|

# bindkey -v               # vi key bindings
bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

if [[ "$TERM" != "linux" ]] &&
    [[ "$TERM" != "eterm-color" ]] && [[ "$TERM" != "dumb" ]]; then
    function precmd() {
	print -nP "\033]2; zsh@%m:%~%# \007\033]1;%m:%~%#\007"
    }
    function preexec() {
	local s=${2//\\/\\\\}; s=${s//\%/%%};
	print -nP -f "\033]2; %s:zsh@%s %-40s\007\033]1;%s %-20s\007" "%m:%~%#" $s "%m:%~%#" $s
    }
fi
