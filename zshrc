ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gthole"

plugins=(git fabric vagrant)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"
export JAVA_HOME="$(/usr/libexec/java_home)"

if [ -f $HOME/.keys ]; then
  source $HOME/.keys
fi

# Tunnel all traffic through ssh
alias shtl="sshuttle --dns -r litbt 0/0 2> /dev/null"

# Whee
alias nosleep="pmset noidle"
function copy() {
  head -n $3 $1 | tail -n $(( $3 - $2 + 1)) | pbcopy
  pbpaste
}

# Set path
export PATH=bin:/usr/local/bin:/usr/local/terraform:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:./.pip:./node_modules/.bin:~/node_modules/.bin:~/.bin:$PATH

alias dm='docker-machine'
alias dc='docker-compose'


# JAVA version switching
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
     fi
     export JAVA_HOME=`/usr/libexec/java_home -v $@`
     export PATH=$JAVA_HOME/bin:$PATH
  fi
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

# RVM never does seem to work correctly ...
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Launch tmux shell on startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Launch tmux if it's installed
if type "tmux" > /dev/null && [[ -z "$TMUX" ]] ;then
  # Load tmux configuration
  tmux source-file ~/.tmux.conf &> /dev/null

  # get the id of a deattached session
  ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
  # if not available create a new one
  if [[ -z "$ID" ]] ;then
    # Start a new session if none available
    exec tmux
  else
    # if available attach to it
    exec tmux attach-session -t "$ID"
  fi
fi
