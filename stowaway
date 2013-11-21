#!/bin/bash
#setup homebrew, dotfiles on a new machine
#not currently tested beyond the stow portion of things, 
#need to set up an empty vagrant image for testing first
set -e
set -o pipefail

pushd $(dirname $0) > /dev/null

#### Setup Homebrew ####
#TODO

#### OS X or Linux? ####
#TODO split bash packages that get stowed based on OS
OS=$(uname -s)
echo "proceeding with hassling stowaways for $OS!"

if [ "Linux" = "$OS" ]; then
    sudo apt-get install stow;
elif [ "Darwin" = "$OS" ]; then
    brew install stow
else
    "Don't know what to do with stowaways on OS named $OS"
    exit 1;
fi

#### get dotfiles repo ####
GITDIR="$HOME/git"
mkdir -p "$GITDIR"
pushd "$GITDIR" > /dev/null
DOTREPO="dotfiles"
#git clone https://github.com/ianferguson/dotfiles.git "$DOTREPO" #TODO add check for git first
DOTDIR="$GITDIR/$DOTREPO"
pushd "$DOTDIR" > /dev/null

#### Stow Stuff ####
#first stow a stow ignore, so we avoid any DS_Store stuff forever
echo "stowing stow files"
stow --ignore ".DS_Store" -t ~ stow

STOWAWAYS=(fish git psql screen tmux htop bash_$OS mongo ssh vim)
for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow -R --adopt -t ~ $STOWAWAY
done;

popd > /dev/null
popd > /dev/null
popd > /dev/null
