function gitup
	# iterate over all dirs in opower dir, and fetch all updates
  # for directories that are git repo's
  for dir in (find ~/git -type d -maxdepth 1 -mindepth 1);
    pushd "$dir";
    and git rev-parse --git-dir > /dev/null;
    and sem -j 64 'git fetch --all > /dev/null'
    popd "$dir";
  end
  sem --wait
  echo "done"
end
