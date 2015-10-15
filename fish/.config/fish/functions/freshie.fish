function freshie
	brew update
  # this used to allow passing through specific packages via $argv but at 
  # somepoint around May 2015 the maintainers of homebrew thought it'd be a
  # great idea to require the use of a --all flag to upgrade all packages, 
  # rather than just letting a bare brew upgrade work for that. since I don't
  # really ever use this alias with a package name, that functionality was removed. :(
  and brew upgrade --all
  and brew cask cleanup
  and brew cleanup
  and brew linkapps

  # in the case that go is updated, the fish env GOROOT will be pointing at
  # the old GOROOT value, which is set mostly for the benefit of godef, godoc
  # and a few other tools that whine if its not set in the shell env, so
  # go ahead and ask the go on our path (which will be the homebrew managed one)
  # what its root is and then export that universally to our fish shells
  and set -gx GOROOT (go env GOROOT)
end
