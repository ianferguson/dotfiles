#!/usr/local/bin/fish
set -gx PATH /usr/local/bin /usr/local/sbin $PATH ~/bin $GOPATH/bin /opt/vertica/bin
status --is-interactive; and . (rbenv init -|psub)
