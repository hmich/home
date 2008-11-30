# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
	. ~/.bashrc
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    export PATH=~/bin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
fi

# set MANPATH to search for user's manual pages
if [ -d ~/share/man ] ; then
    export MANPATH=~/share/man:$MANPATH
fi

if [ -z "$http_proxy" ] ; then
    export http_proxy=$HTTP_PROXY
fi
