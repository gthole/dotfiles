#!bin/bash

# Much of this lifted directly from
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

# Brew packages
# If Homebrew isn't installed, then install it.
if [ ! -x /usr/local/bin/brew ]; then
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# get ready for installing
brew update

# Install!
brew install git watch wget htop python3 node ag sshuttle cowsay tor torsocks s3cmd
brew install imagemagick libpng jpeg libtiff

# Give htop root access
sudo chown root:wheel /usr/local/Cellar/htop-osx/*/bin/htop
sudo chmod u+s /usr/local/Cellar/htop-osx/*/bin/htop

echo "All done"
