function git_branch
  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  if test -n "$git_dir"
    set -l git_status (git status --porcelain)
    set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
    if test -n "$git_status"
        printf ' %s(%s)%s ' (set_color red) (echo $branch) (set_color normal)
    else
        printf ' %s(%s)%s ' (set_color cyan) (echo $branch) (set_color normal)
    end
  else
    printf ' '
  end
end

function docker_prompt
  if set -q DOCKER_HOST
    if echo $DOCKER_HOST | grep -q -E '192\.168\.99.+'
        set fish_docker_color cyan
    else
        set fish_docker_color ff6a00
    end
  else
    set fish_docker_color normal
  end
    printf '%s▶%s' (set_color $fish_docker_color) (set_color normal)
end

function fish_prompt

  printf ' %s%s%s%s ' (set_color $fish_color_cwd) (prompt_pwd) (git_branch) (docker_prompt)
end
