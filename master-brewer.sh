#!/bin/bash

set -e

ruby -e brew-starter.rb 
read -p "Install complete, press enter to continue..."

brew doctor
read -p "Doctor check complete, press enter to continue..."

brew update
read -p "Update complete, press enter to run install of default brews..."

for BREW in $(cat brews); do
    echo "installing $BREW!"
    brew install $BREW
done

echo "you're done brewing, kick back and enjoy the 6 pack, bro!"

