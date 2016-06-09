#!/usr/local/bin/fish
set -gx PATH /usr/local/bin /usr/local/sbin $PATH ~/bin $GOPATH/bin

# load in opower specific env vars
source ~/.opower_env.fish

# do whatever horrible things rbenv needs to do to make ruby not as horrible
status --is-interactive; and . (rbenv init -|psub)
