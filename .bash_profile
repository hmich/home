if [ -f ~/.profile ]; then
    . ~/.profile
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
