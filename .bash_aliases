#! /bin/bash

LS_OPTIONS='-h'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #eval "`dircolors -b`"
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    LS_OPTIONS="$LS_OPTIONS --color=auto"
    alias grep='grep --color=auto'
fi

grepv () {
  VAR="";
  OPTIONS="";
  STR="";
  for ((i=1; i<$#; i++)) do
    eval VAR=\$$i;
    OPTIONS="$OPTIONS $VAR";
  done
  eval STR=\$$#;
  echo "find . -path '*work*' -prune -o -path '*INCA*' -prune -o -name '*.v' -exec grep -H $OPTIONS \"$STR\" {} \;";
  find . -path '*work*' -prune -o -path '*INCA*' -prune -o -name '*.v' -exec grep -H $OPTIONS "$STR" {} \;
}

alias ls='ls $LS_OPTIONS'
# some more ls aliases
#alias ll='ls $LS_OPTIONS -l'
#alias la='ls $LS_OPTIONS -A'
#alias  l='ls $LS_OPTIONS -CF'


# tmux in 256 colors
alias tmux='tmux -2'

alias df='df -h'
#alias du='du -h'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
#alias cp='cp -i'
alias mv='mv -i'
alias sl='ls'
alias cd..='cd ..'


alias ll='ls -alFt'
alias la='ls -A'
alias lstr='ls -ltr'
alias lsrt='ls -ltr'
alias sltr='ls -ltr'
alias slrt='ls -ltr'

lcd(){
\cd $1
ls
}


# Personal aliases
[ -f ~/.bash_aliases.local ] && source ~/.bash_aliases.local

