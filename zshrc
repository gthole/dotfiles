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

# Set path
export PATH=/usr/local/bin:/usr/local/heroku/bin:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:~/.rvm/bin:node_modules/.bin:~/node_modules/.bin:$PATH

# RVM never does seem to work correctly ...
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Load tmux configuration
tmux source-file ~/.tmux.conf &> /dev/null

# Launch tmux shell on startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -z "$TMUX" ]] ;then
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
