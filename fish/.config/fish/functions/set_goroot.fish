function set_goroot -d "Find the most up to date homebrew installed go installtation and set that as the GOROOT env var"
  # in the case that go is updated, the fish env GOROOT will be pointing at
  # the old GOROOT value, which is set mostly for the benefit of godef, godoc
  # and a few other tools that whine if its not set in the shell env, so
  # given that we've cleaned up all the unused things, there should only
  # be one version path under the Cellar/go, so glob that in
  set -ge GOROOT;
  set -Ue GOROOT;
  set -Ux GOROOT (find /usr/local/Cellar/go -maxdepth 1 -mindepth 1 -type d | sort -rn | head -1)/libexec
end
