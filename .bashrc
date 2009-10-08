#!/bin/sh

shopt | grep login_shell | grep -q on && ISLOGINSHELL=1

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f ~/.rc ] && . ~/.rc

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

export PROMPT_COMMAND='history -a'
export CDPATH='.:~/.:/media:/etc:/usr:/usr/local'

shopt -s autocd checkjobs checkwinsize cdable_vars cdspell \
         cmdhist dirspell dotglob globstar histappend \
         no_empty_cmd_completion 2>/dev/null

PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#     ;;
# *)
#     ;;
# esac
# 
