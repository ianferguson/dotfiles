function reponame
	basename (git remote show -n origin 2> /dev/null | grep Fetch | cut -d: -f2-) | awk 'BEGIN{FS="."}{print$1}' 2> /dev/null; 
end
