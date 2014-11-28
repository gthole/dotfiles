#!bin/bash

# Much of this copied directly from
# https://gitlab.com/paulswartz/dotfiles/blob/master/setup.sh

here="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Linking from $here"

_ln() {
  rm -rf $2
  ln -Ffhs $here/$1 $2
}

for dotfile in vim vimrc zshrc oh-my-zsh gitconfig gitignore_global; do
  _ln $dotfile ~/.${dotfile}
done

# Copy theme file into oh-my-zsh themes
_ln gthole.zsh-theme $here/oh-my-zsh/themes/

echo "All done"
