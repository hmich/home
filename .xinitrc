xsetroot -solid "#000000"
xrdb -merge ~/.Xresources
xmodmap ~/.xmodmaprc

export FONT="-xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1"

# if we have private ssh key(s), start ssh-agent and add the key(s)
id1=$HOME/.ssh/identity
id2=$HOME/.ssh/id_dsa
id3=$HOME/.ssh/id_rsa
if [ -x /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 -o -f $id3 ]; then
    eval `ssh-agent -s`
    ssh-add < /dev/null
fi

xmonad & 
PID=$!
#urxvt -name "term" -e screen &
#emacs &
#opera &
#urxvt -name ncmpc -e ncmpc &
#urxvt -name htop -e htop &
#urxvt -name irssi -e irssi &

wait $PID

pkill -HUP urxvt
pkill -HUP emacs
pkill -HUP opera

wait
