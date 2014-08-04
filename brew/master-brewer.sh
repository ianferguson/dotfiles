#!/bin/bash

set -e

echo "installing homebrew"
ruby -e brew-starter.rb 

echo "checking brew install for issues"
brew doctor || true

echo "updating brew indexes"
brew update

echo "installing brews"
brew bundle Brewfile

echo "installing casks"
brew bundle Caskfile

echo "cleaning up old versions"
brew cleanup

echo "double checking install health"
brew doctor

echo "you're done brewing"

