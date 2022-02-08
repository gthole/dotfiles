#!bin/bash

# Much of this lifted directly from
# https://gitlab.com/paulswartz/dotfiles/blob/master/setup.sh

here="$( cd "$(dirname "$0")" ; pwd -P )"

echo "Linking from $here"

_ln() {
  rm -rf $2
  ln -Ffhs $here/$1 $2
}

for dotfile in vim vimrc zshrc tmux.conf tmux-profiles oh-my-zsh gitconfig gitignore_global mbtastatusrc xonshrc; do
  _ln $dotfile ~/.${dotfile}
done

_ln fish ~/.config/fish
_ln bin/pw /usr/local/bin/pw

# Copy theme file into oh-my-zsh themes
_ln gthole.zsh-theme $here/oh-my-zsh/themes/gthole.zsh-theme

# Brew packages
# If Homebrew isn't installed, then install it.
if [ ! -x /usr/local/bin/brew ]; then
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# get ready for installing
brew update

# Install!
brew install fish tmux git watch wget htop python3 node ag pass
# brew install imagemagick libpng jpeg libtiff
# brew install reattach-to-user-namespace

# Latest vim is problematic with NERDTree
# brew install vim

if [ "$SHELL" != "/usr/local/bin/fish" ]; then
  echo "Making fish the default shell"
  sudo echo "/usr/local/bin/fish" >> /etc/shells
  chsh -s /usr/local/bin/fish
fi

# Give htop root access
sudo chown root:wheel /usr/local/Cellar/htop-osx/*/bin/htop
sudo chmod u+s /usr/local/Cellar/htop-osx/*/bin/htop

# Install npm packages
cd
npm install jscs jshint gthole/mbtastatusline

echo "All done"
