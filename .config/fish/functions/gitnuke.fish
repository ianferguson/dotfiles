function gitnuke --description 'update and clean up local repo'
	set branch (git rev-parse --abbrev-ref HEAD) 
    and git checkout develop
    and git pull
	and git remote prune origin
	and git prune
	and git branch --merged  | grep -v \*  | xargs git branch -D $argv
    and git gc
    and git checkout $branch
end
