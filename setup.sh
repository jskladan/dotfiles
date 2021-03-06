#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## init and update submodules
git submodule init
git submodule update

########## Variables

dir=`realpath ./dotfiles`                    # dotfiles directory
olddir=`realpath ./dotfiles_old`             # old dotfiles backup directory
files=`ls ${dir}`    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ${olddir}/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
