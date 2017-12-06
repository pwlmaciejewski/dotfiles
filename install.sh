#!/bin/bash

# Get dotfiles dir
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Handy pointers
BASHRC=~/.bashrc
VIMRC=~/.vimrc
GITCONFIG=~/.gitconfig
SUBLIME_CONFIG_DIR=~/.config/sublime-text-2/Packages/Default
GRUNT=~/.grunt

# Backup function checks if file exists and moves
# it to a backup (eg. ~/.bashrc -> ~/.bashrc.old)
function backup {
  if [ -e $1 ]
  then
    $(mv $1 $(dirname $1)/$(basename $1).old)
  fi
}

# Install function takes two arguments. First is
# the file to install and the second is destination.
# If destination already exists it will be backed up.
function link {
  backup $2
  $(ln -s $1 $2)
}

# Install bashrc
backup $BASHRC
echo "# Don't delete this line" >> $BASHRC
echo -e "source ${DIR}/.bashrc\n" >> $BASHRC

# Install gitconfig
link ${DIR}/.gitconfig $GITCONFIG

# Install vimrc
backup $VIMRC
echo "\" Don't delete this line" >> $VIMRC
echo -e "source $DIR/.vimrc\n" >> $VIMRC

# Install vundle (vim bundles manager)
if [ -d ~/.vim/bundle/vundle ]
then
  rm -rf ~/.vim/bundle/vundle
fi
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Now it's time to install vim bundles
vim -e +BundleInstall! +BundleClean +qa 2> /dev/null
