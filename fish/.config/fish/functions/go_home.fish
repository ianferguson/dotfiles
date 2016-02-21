function go_home
	set -gx GOROOT (ls -1 /usr/local/Cellar/go/ | sort -n | tail -1)
end
