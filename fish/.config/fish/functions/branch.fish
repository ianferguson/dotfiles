function branch
	git rev-parse --abbrev-ref HEAD 2> /dev/null $argv; 
end
