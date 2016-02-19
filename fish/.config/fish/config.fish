#!/usr/local/bin/fish
set -gx PATH /usr/local/bin /usr/local/sbin $PATH ~/bin $GOPATH/bin

# this shouldn't be necessary but I did something stupid at some point and now
# having this in here makes my life easier than not having it
set -gx GOROOT /usr/local/Cellar/go/*/libexec

# do whatever horrible things rbenv needs to do to make ruby not as horrible
status --is-interactive; and . (rbenv init -|psub)
