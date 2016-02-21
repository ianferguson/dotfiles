function freshie
	brew update
  # this used to allow passing through specific packages via $argv but at
  # somepoint around May 2015 the maintainers of homebrew thought it'd be a
  # great idea to require the use of a --all flag to upgrade all packages,
  # rather than just letting a bare brew upgrade work for that. since I don't
  # really ever use this alias with a package name, that functionality was removed. :(
  and brew upgrade --all
  brew cask cleanup
  brew cleanup
  brew linkapps > /dev/null

  # in the case that go is updated, the fish env GOROOT will be pointing at
  # the old GOROOT value, which is set mostly for the benefit of godef, godoc
  # and a few other tools that whine if its not set in the shell env, so
  # given that we've cleaned up all the unused things, there should only
  # be one version path under the Cellar/go, so glob that in

  set -gx GOROOT (ls -1 /usr/local/Cellar/go/ | sort -n | tail -1)
end
