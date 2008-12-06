# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f ~/.rc ]; then
    . ~/.rc
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

export PROMPT_COMMAND='history -a'
export CDPATH='.:~/.:/media:/etc:/usr:/usr/local'

shopt -s checkwinsize cdable_vars cdspell cmdhist dotglob histappend

PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

sd() {
    DIR="$1"
    [ -z "$DIR" ] && DIR="$(sel)" && if [ ! -d "$DIR" ]; then DIR="$(dirname "$DIR")"; fi
    [ -d "$DIR" ] && pushd "$DIR" && ls
}

fortune
