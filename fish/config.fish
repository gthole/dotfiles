set PATH /usr/local/bin ./node_modules/.bin ~/node_modules/.bin $PATH

alias dm='docker-machine'
alias dc='docker-compose'

init_tmux

if test $HOME/.keys
    source $HOME/.keys
end
