function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$fg[green]%}%p %{$fg[green]%}%c %{$reset_color%}$(git_prompt_info)>> %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=") %{$reset_color%}"
