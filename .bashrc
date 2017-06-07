# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export SHELL=/bin/bash

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000000
HISTFILESIZE=4000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

#--------------------------------------------------------------
# xterm title
#--------------------------------------------------------------
XTERM_TITLE='${USER}@${HOSTNAME/.*}:${PWD/$HOME/\~}'
case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND='eval "echo -ne \"\033]0;${XTERM_TITLE}\007\""'
    ;;
  *)
    ;;
esac
#--------------------------------------------------------------

#--------------------------------------------------------------
# prompt
#--------------------------------------------------------------
if tput colors &> /dev/null
then
  # see man 4 console_codes
  # \[ and \] are used in bash prompt (see man bash PROMPTING) to start and
  # end a sequence character so size of prompt is correctly computed.
  export COLOR_BLACK="\[\033[0;30m\]"
  export COLOR_DARKGRAY="\[\033[1;30m\]"
  export COLOR_RED="\[\033[0;31m\]"
  export COLOR_LIGHT_RED="\[\033[1;31m\]"
  export COLOR_GREEN="\[\033[0;32m\]"
  export COLOR_LIGHT_GREEN="\[\033[1;32m\]"
  export COLOR_BROWN="\[\033[0;33m\]"
  export COLOR_YELLOW="\[\033[1;33m\]"
  export COLOR_BLUE="\[\033[0;34m\]"
  export COLOR_LIGHT_BLUE="\[\033[1;34m\]"
  export COLOR_PURPLE="\[\033[0;35m\]"
  export COLOR_LIGHT_PURPLE="\[\033[1;35m\]"
  export COLOR_CYAN="\[\033[0;36m\]"
  export COLOR_LIGHT_CYAN="\[\033[1;36m\]"
  export COLOR_GRAY="\[\033[0;37m\]"
  export COLOR_WHITE="\[\033[1;37m\]"
  export COLOR_NEUTRAL="\[\033[0m\]"
fi

fancy_prompt () {
  return_code="$?"
  if [ "$return_code" = 0 ]
  then
      local arrow="${COLOR_LIGHT_GREEN}"
  else
      local arrow="${COLOR_RED}"
  fi
  local arrow+=">"
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_DESCRIBE_STYLE="branch"
  local git=$(__git_ps1 "${COLOR_NEUTRAL}on ${COLOR_LIGHT_CYAN}%s${COLOR_NEUTRAL}" 2> /dev/null)
  export PS1="${COLOR_RED}\u${COLOR_NEUTRAL}@${HILIT}\h${COLOR_NEUTRAL}:${COLOR_YELLOW}\w $git\n$arrow${COLOR_NEUTRAL} "
}

if [[ "${DISPLAY#$HOST}" != ":0.0" &&  "${DISPLAY}" != ":0" ]]; then
    HILIT=${COLOR_LIGHT_BLUE}   # remote machine
else
    HILIT=${COLOR_LIGHT_GREEN}  # local machine
fi

# execute xterm_autotitle for each prompt
PROMPT_COMMAND="fancy_prompt ; $PROMPT_COMMAND"
#--------------------------------------------------------------

#--------------------------------------------------------------
# custom aliases
#--------------------------------------------------------------
# tmux in 256 colors
alias tmux='tmux -2'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

## use nvim
#if type nvim &> /dev/null
#then
#  alias vim='nvim'
#fi
#--------------------------------------------------------------

# fzf: fuzzy search
if type ag &> /dev/null; then
   export FZF_DEFAULT_COMMAND='ag -g ""'
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# put custom binaries in ~/bin
export PATH=${PATH}:~/bin
for file in ~/bin/completion/*
do
  [ -f $file ] && source $file
done

# cd --
[ -f ~/bin/acd_func.sh ] && source ~/bin/acd_func.sh

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
