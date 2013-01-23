if [ -f ~/.rc ]; then
    . ~/.rc
fi

if [ -f ~/.zshaliases ]; then
    . ~/.zshaliases
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

#export CDPATH=".:/etc"

# Directories
setopt auto_cd auto_pushd pushd_ignore_dups

# Completion
#setopt auto_list auto_menu
setopt always_to_end auto_name_dirs no_auto_menu
setopt list_packed complete_in_word no_list_ambiguous

# Expansion and globbing
setopt glob_dots mark_dirs #extended_glob

# History
setopt extended_history hist_ignore_dups hist_reduce_blanks share_history

# Input/output
setopt correct notify print_exit_value

# Zle
setopt nobeep emacs

bindkey ' '   magic-space    # do history expansion on space
bindkey '\ei' menu-complete  # menu completion via esc-i

bindkey -s '^l' " | less\n"

source ~/.zshprompt

autoload -Uz compinit
compinit -u

zmodload zsh/complist
bindkey -M menuselect '\C-\n' accept-and-hold

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

zstyle ':completion:*' use-cache on
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' expand 'yes'
#zstyle ':completion:*' menu yes select

# autoload -U zsh-mime-setup
# zsh-mime-setup

chpwd() {
	#ROWS=`stty size | cut -d' ' -f1`
	#FILES=`find . -maxdepth 1 -mindepth 1 | wc -l | tr -d '[:space:]'`

	# if the terminal has enough lines, do a long listing
	#if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
	ls 
	#else
	#	ls --color -hlAF --full-time
	#fi
}

if [ "$TERM" = screen ]; then
    bindkey "\e[1~" beginning-of-line
    bindkey "\e[4~" end-of-line
    bindkey "\e[3~" delete-char
    bindkey "^[[A"  up-line-or-search
    bindkey "^[[B"  down-line-or-search
fi

is_login_shell() {
    setopt | grep -q login
}

for file in ~/.rc/*; do
    source "$file"
done

source /etc/bash_completion.d/g4d
