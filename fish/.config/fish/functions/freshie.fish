function freshie
	brew update
  and brew upgrade $argv
  and brew cask cleanup
  and brew cleanup

  # in the case that go is updated, the fish env GOROOT will be pointing at
  # the old GOROOT value, which is set mostly for the benefit of godef, godoc
  # and a few other tools that whine if its not set in the shell env, so
  # go ahead and ask the go on our path (which will be the homebrew managed one)
  # what its root is and then export that universally to our fish shells
  set -Ux GOROOT (go env GOROOT)
end
