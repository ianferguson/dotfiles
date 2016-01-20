function fork_clone
	set url "$argv[1]"
  set repo (echo $url | sed -e 's/.*://' -e 's|/| |' -e 's/\.git$//' | cut -f2 -d ' ')
	hub clone $url
  and pushd $repo
  and hub fork
  and git remote rename origin upstream
  and git remote rename ian-ferguson origin
  # git branch -u origin/master
  popd
end
