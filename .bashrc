# ~/.profile: executedy the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

alias ls="ls -G"
export MPJ_HOME=/mpj
export PATH=$PATH:$MPJ_HOME/bin
alias javacmpi="javac -cp .:$MPJ_HOME/lib/mpj.jar"
alias mpjrun="mpjrun.sh"
 #set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

PS1='[\[\e[1;32m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\]][\[\e[1;34m\]\w\[\e[m\]] > '
  # change the color of root
if [ "${USER}" == "root" ] ; then
    PS1='[\[\e[1;33m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\]][\[\e[1;34m\]\w\[\e[m\]] > '
fi
PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME} - ${PWD}\007"'

# function for cd + ls combo
function cd () {
  if [ -z "$1" ] ; then
    return
  fi
  builtin cd "$@" && ls 
}

# function for extracting zip/tar files
extract () {
  if [ -f $1 ] ; then
    case $1 in
    *.tar.bz2)  tar xjf $1      ;;
    *.tar.gz)   tar xzf $1      ;;
    *.bz2)      bunzip2 $1      ;;
    *.rar)      rar x $1        ;;
    *.gz)       gunzip $1       ;;
    *.tar)      tar xf $1       ;;
    *.tbz2)     tar xjf $1      ;;
    *.tgz)      tar xzf $1      ;;
    *.zip)      unzip $1        ;;
    *.Z)        uncompress $1   ;;
    *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file - go home"
  fi
}

set -o vi

PATH="$HOME/bin:$PATH"

PS1='[\[\e[1;32m\]\w\[\e[m\]] > '
