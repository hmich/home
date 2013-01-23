setxkbmap -layout us,ru -variant ,winkeys -option grp:rwin_toggle
xsetroot -solid "#000000"
xrdb -merge ~/.Xresources
xmodmap ~/.xmodmaprc

export FONT="-xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1"

xscreensaver &
runterm &
xmonad & 
PID=$!

#urxvt -name "term" -e screen &
#emacs &
#opera &
#urxvt -name ncmpc -e ncmpc &
#urxvt -name htop -e htop &
#urxvt -name irssi -e irssi &

wait $PID

#pkill -HUP urxvt
#pkill -HUP emacs
#pkill -HUP opera

#wait
