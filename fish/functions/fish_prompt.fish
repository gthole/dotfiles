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
  set dm_name ""
  if set -q DOCKER_MACHINE_NAME
    set dm_name "[$DOCKER_MACHINE_NAME] "
    switch (echo $DOCKER_MACHINE_NAME)
      case ids
        set fish_docker_color brblue
      case fdr
        set fish_docker_color brblue
      case '*'
        set fish_docker_color cyan
    end
  else
    set fish_docker_color normal
  end
    printf '%s%s▶%s' (set_color $fish_docker_color) (echo $dm_name) (set_color normal)
end

function fish_prompt

  printf ' %s%s%s%s ' (set_color $fish_color_cwd) (prompt_pwd) (git_branch) (docker_prompt)
end
