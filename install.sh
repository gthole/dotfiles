#!bin/bash

# Much of this lifted directly from
# https://gitlab.com/paulswartz/dotfiles/blob/master/setup.sh

here="$( cd "$(dirname "$0")" ; pwd -P )"

if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Making zsh the default shell"
  chsh -s /bin/zsh
fi

echo "Linking from $here"

_ln() {
  rm -rf $2
  ln -Ffhs $here/$1 $2
}

for dotfile in vim vimrc zshrc jscsrc jshintrc tmux.conf tmux-profiles oh-my-zsh gitconfig gitignore_global mbtastatusrc; do
  _ln $dotfile ~/.${dotfile}
done

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
brew install tmux git watch wget htop python3 node ag sshuttle cowsay tor torsocks s3cmd
brew install imagemagick libpng jpeg libtiff
brew install reattach-to-user-namespace

# Latest vim is problematic with NERDTree
# brew install vim

# Give htop root access
sudo chown root:wheel /usr/local/Cellar/htop-osx/*/bin/htop
sudo chmod u+s /usr/local/Cellar/htop-osx/*/bin/htop

# Install npm packages
cd
npm install jscs jshint gthole/mbtastatusline

echo "All done"
