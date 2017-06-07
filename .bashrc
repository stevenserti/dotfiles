#! /bin/bash

export SHELL=/bin/bash

[ -d ~/bin ] && PATH="~/bin:${PATH}"


# Sigma common bashrc
source /utils/unix_share/bash/sigma.bashrc


############################################################

# Don't run the following in non interactively shell
[ -z "$PS1" ] && return


############################################################


PS1='\u@\h:\w$ '

# Set your own prompt with color
#PS1="$COLOR_BLUE\u@$COLOR_YELLOW\h:$COLOR_GREEN\w\$$COLOR_NEUTRAL "


# RDESKTOP variable should be extended as follow (please see man rdesktop)
# in .bashrc after sourcing this file
export RDESKTOP="rdesktop"
# Append personal arg to RDESKTOP variable

#RDESKTOP="$RDESKTOP -K -g 1024x768 -a 24"
# for fr keyboard :
#RDESKTOP="$RDESKTOP -k fr"
# for automatic password :
#RDESKTOP="$RDESKTOP -p password"



############################################################


# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -q -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -q -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


############################################################


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


############################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi



# Personal bashrc stuff
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
