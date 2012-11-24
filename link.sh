#!/bin/bash
GIT_DIR=$PWD

cd $HOME
files=(
  .bashrc
  .vim
  .vimrc
  .gitconfig
)

function link_files() {
  for file in $@ ; do
    if [ -e $file ] ; then
      echo $HOME/$file already exists - aborting link
    else
      ln -vs $GIT_DIR/$file $file
    fi
  done
}

link_files ${files[@]}
