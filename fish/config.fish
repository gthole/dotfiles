set PATH /usr/local/bin ./node_modules/.bin ~/node_modules/.bin $PATH

alias dm='docker-machine'
alias dc='docker-compose'

# Because I keep typing this thinking I'm in vim
alias jk='curl -H "Accept: text/plain" https://icanhazdadjoke.com/'

init_tmux

if test $HOME/.keys
    source $HOME/.keys
end
