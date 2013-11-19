#!/bin/bash
#setup homebrew, dotfiles on a new machine
#not currently tested beyond the stow portion of things, 
#need to set up an empty vagrant image for testing first
set -e
set -o pipefail

#### get dotfiles repo ####
GITDIR="$HOME/git"
mkdir -p "$GITDIR"
pushd "$GITDIR" > /dev/null
DOTREPO="dotfiles"
#git clone https://github.com/ianferguson/dotfiles.git "$DOTREPO" #TODO add check for git first
DOTDIR="$GITDIR/$DOTREPO"
pushd "$DOTDIR" > /dev/null

#### Setup Homebrew ####
#TODO

#### Stow Stuff ####
#first stow a stow ignore, so we avoid any DS_Store stuff forever
echo "stowing stow files"
stow --ignore ".DS_Store" -t ~ stow

STOWAWAYS=(fish git psql screen tmux htop bash mongo ssh vim)
for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow -t ~ $STOWAWAY
done;

popd  > /dev/null
popd  > /dev/null

