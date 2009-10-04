#umask 022

if [ -d ~/bin ] ; then
    export PATH=~/bin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
fi

if [ -d ~/share/man ] ; then
    export MANPATH=~/share/man:$MANPATH
fi

if [ -z "$http_proxy" ] ; then
    export http_proxy=$HTTP_PROXY
fi
