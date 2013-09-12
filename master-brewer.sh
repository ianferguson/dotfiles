#!/bin/bash

set -e

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew update

for BREW in $(cat brews); do
    brew install $BREW
done

