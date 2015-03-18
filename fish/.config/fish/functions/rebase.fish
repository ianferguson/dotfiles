function rebase
	
  # and basically udpates that branch and then rebase the current branch against
  # that branch
  git checkout $argv
  and git pull
  and git checkout -
  and git rebase -
end
