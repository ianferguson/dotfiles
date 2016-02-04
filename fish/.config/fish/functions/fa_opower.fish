function fa_opower
	# iterate over all dirs in opower dir, and fetch all updates
  # for directories that are git repo's
  for dir in (find ~/opower -type d -maxdepth 1 -mindepth 1);
    pushd "$dir";
    and git rev-parse --git-dir > /dev/null;
    and git fetch --all;
    popd "$dir";
  end
end
