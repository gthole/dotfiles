set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

set PATH /usr/local/bin ./node_modules/.bin ~/node_modules/.bin $PATH

alias activate='source ./.venv/bin/activate.fish'
alias dm='docker-machine'
alias dc='docker compose'

# Because I keep typing this thinking I'm in vim
alias jk='curl -H "Accept: text/plain" https://icanhazdadjoke.com/'

alias json='python -m json.tool'

init_tmux

if test $HOME/.keys
    source $HOME/.keys
end
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
