function gitnuke
	git checkout develop
	and git branch --merged  | grep -v \*  | xargs git branch -D $argv
end
