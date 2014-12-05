ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gthole"

plugins=(git fabric vagrant)

source $ZSH/oh-my-zsh.sh

export JAVA_HOME="$(/usr/libexec/java_home)"

if [ -f $HOME/.keys ]; then
  source $HOME/.keys
fi

# Tunnel all traffic through ssh
alias shtl="sshuttle --dns -r litbt 0/0 2> /dev/null"

# Set path
export PATH=/usr/local/bin:/usr/local/heroku/bin:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:~/.rvm/bin:$PATH

# RVM never does seem to work correctly ...
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

