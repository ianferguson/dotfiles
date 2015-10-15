function abbr --description 'Manage abbreviations'
	# parse arguments
	set -l mode
	set -l mode_flag # the flag that was specified, for better errors
	set -l mode_arg
	set -l needs_arg no
	while set -q argv[1]
		if test $needs_arg = single
			set mode_arg $argv[1]
			set needs_arg no
		else if test $needs_arg = coalesce
			set mode_arg "$argv"
			set needs_arg no
			set -e argv
		else
			set -l new_mode
			switch $argv[1]
			case '-h' '--help'
				__fish_print_help abbr
				return 0
			case '-a' '--add'
				set new_mode add
				set needs_arg coalesce
			case '-e' '--erase'
				set new_mode erase
				set needs_arg single
			case '-l' '--list'
				set new_mode list
			case '-s' '--show'
				set new_mode show
			case '--'
				set -e argv[1]
				break
			case '-*'
				printf ( _ "%s: invalid option -- %s\n" ) abbr $argv[1] >&2
				return 1
			case '*'
				break
			end
			if test -n "$mode" -a -n "$new_mode"
				# we're trying to set two different modes
				printf ( _ "%s: %s cannot be specified along with %s\n" ) abbr $argv[1] $mode_flag >&2
				return 1
			end
			set mode $new_mode
			set mode_flag $argv[1]
		end
		set -e argv[1]
	end
	if test $needs_arg != no
		printf ( _ "%s: option requires an argument -- %s\n" ) abbr $mode_flag >&2
		return 1
	end
	
	# If run with no options, treat it like --add if we have an argument, or
	# --show if we do not have an argument
	if test -z "$mode"
		if set -q argv[1]
			set mode 'add'
			set mode_arg "$argv"
			set -e argv
		else
			set mode 'show'
		end
	end

	# none of our modes want any excess arguments
	if set -q argv[1]
		printf ( _ "%s: Unexpected argument -- %s\n" ) abbr $argv[1] >&2
		return 1
	end

	switch $mode
	case 'add'
		set -l key
		set -l value
		__fish_abbr_parse_entry $mode_arg key value
		# ensure the key contains at least one non-space character
		set -l IFS \n\ \t
		printf '%s' $key | read -lz key_ __
		if test -z "$key_"
			printf ( _ "%s: abbreviation must have a non-empty key\n" ) abbr >&2
			return 1
		end
		if test -z "$value"
			printf ( _ "%s: abbreviation must have a value\n" ) abbr >&2
			return 1
		end
		if set -l idx (__fish_abbr_get_by_key $key)
			# erase the existing abbreviation
			set -e fish_user_abbreviations[$idx]
		end
		if not set -q fish_user_abbreviations
			# initialize as a universal variable, so we can skip the -U later
			# and therefore work properly if someone sets this as a global variable
			set -U fish_user_abbreviations
		end
		set fish_user_abbreviations $fish_user_abbreviations $mode_arg
		return 0

	case 'erase'
		set -l key
		__fish_abbr_parse_entry $mode_arg key
		if set -l idx (__fish_abbr_get_by_key $key)
			set -e fish_user_abbreviations[$idx]
			return 0
		else
			printf ( _ "%s: no such abbreviation '%s'\n" ) abbr $key >&2
			return 2
		end

	case 'show'
		for i in $fish_user_abbreviations
			# Disable newline splitting
			set -lx IFS ''
			__fish_abbr_parse_entry $i key value
			
			# Check to see if either key or value has a leading dash
			# If so, we need to write --
			set -l opt_double_dash ''
			switch $key ; case '-*'; set opt_double_dash ' --'; end
			switch $value ; case '-*'; set opt_double_dash ' --'; end
			echo abbr$opt_double_dash (__fish_abbr_escape "$key") (__fish_abbr_escape "$value")
		end
		return 0

	case 'list'
		for i in $fish_user_abbreviations
			set -l key
			__fish_abbr_parse_entry $i key
			printf "%s\n" $key
		end
		return 0
	end
end
