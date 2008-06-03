HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

export EDITOR=gvim
#export CDPATH=".:/etc"

# Directories
setopt auto_cd cdable_vars pushd_ignore_dups

# Completion
#setopt auto_list auto_menu
setopt always_to_end auto_name_dirs 
setopt list_packed complete_in_word no_list_ambiguous

# Expansion and globbing
setopt glob_dots mark_dirs no_case_glob extended_glob

# History
setopt extended_history hist_ignore_dups hist_reduce_blanks share_history

# Input/output
setopt correct notify print_exit_value 

# Zle
setopt nobeep emacs

source ~/.zshprompt

autoload -Uz compinit
compinit -u

zmodload zsh/complist
bindkey -M menuselect '\C-\n' accept-and-hold

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' menu yes select search

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -f ~/.zshaliases ]; then
    . ~/.zshaliases
fi

autoload -U zsh-mime-setup
zsh-mime-setup

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

chpwd() {
	# filesystem stats
	#echo "`df -hT .`"
	#echo ""
	#echo -n "[`pwd`:"
	# count files
	#echo -n " <`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
	# count sub-directories
	#echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
	# count links
	#echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
	# total disk space used by this directory and all subdirectories
	#echo " <~`du -sh . 2> /dev/null | cut -f1`>]"
    #echo "]"
	ROWS=`stty size | cut -d' ' -f1`
	FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`
	# if the terminal has enough lines, do a long listing
	if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
		ls --color -ACF
	else
		ls --color -hlAF --full-time
	fi
}

