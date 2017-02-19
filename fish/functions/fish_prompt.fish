set fish_git_dirty_color red

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status --porcelain)

  if test -n "$git_status"
    printf '(%s)%s' (echo $branch) (set_color $fish_git_dirty_color)
  else
    printf '(%s)%s' (echo $branch) (set_color normal)
  end
end

function fish_prompt
  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  if test -n "$git_dir"
    printf ' %s%s %s%s >>%s ' (set_color $fish_color_cwd) (prompt_pwd) (set_color blue) (parse_git_branch) (set_color normal)
  else
    printf ' %s%s%s >> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
