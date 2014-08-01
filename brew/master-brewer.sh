#!/bin/bash

set -e

echo "installing homebrew"
#ruby -e brew-starter.rb 

echo "checking brew install for issues"
brew doctor || true

echo "updating brew indexes"
brew update

echo "tapping caskroom"
brew tap phinze/cask
brew upgrade

echo "installing brews"
for BREW in $(cat brews); do
    echo "installing $BREW!"
    brew install $BREW
done

echo "installing casks"
for CASK in $(cat casks); do
    echo "installing $CASK"
    brew cask install $CASK --force
done

brew upgrade

echo "cleaning up old versions"
brew cleanup

echo "double checking install health"
brew doctor

echo "you're done brewing"

