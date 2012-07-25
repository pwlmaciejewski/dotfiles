#!/bin/bash

# Get dotfiles dir
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup function checks if file exists and moves
# it to a backup (eg. ~/.bashrc -> ~/.bashrc.old)
function backup {
  if [ -f $1 ]
  then
    $(mv $1 $(dirname $1)/$(basename $1).old)
  fi
}

# Install function takes two arguments. First is
# the file to install and the second is destination.
# If destination already exists it will be backed up.
function install {
  backup $2
  $(ln -s $1 $2)
}

# Install rc files
install ${DIR}/.bashrc ${HOME}/.bashrc
install ${DIR}/.vimrc ${HOME}/.vimrc

# Backup & create bash_aliases
backup ${HOME}/.bash_aliases
$(touch ${HOME}/.bash_aliases)

# Install vundle (vim bundles manager)
if [ -d ~/.vim/bundle/vundle ]
then
  rm -rf ~/.vim/bundle/vundle
fi
git clone https://github.com/gmarik/vundle.git ${HOME}/.vim/bundle/vundle

# Now it's time to isntall vim bundles
vim -e +BundleInstall! +BundleClean +qa 2> /dev/null
