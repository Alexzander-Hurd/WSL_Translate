#!/usr/bin/env bash

# This checks whether the script was sourced into the current shell or called in a subprocess. This helps determine return vs exit calls
(return 0 2>/dev/null)
sourced=$?

# If .env file exists then read out all the vars and replace them if they aren't already defined in the environment
if [[ -f .env ]]; then
	while IFS='= ' read -r key value; do
		if ! eval "[[ -n \"\${$key}\" ]]"; then
    			export "$key"="$value"
		fi
	done < <(grep -v '#' .env | xargs -L1)
fi

# Default values in case of no .env file and unset envars
if [[ -z "${WSL_TRANSLATE_FUNC}" ]]; then
	export WSL_TRANSLATE_FUNC=stdout
fi

if [[ -z "${WSL_TRANSLATE_MNT}" ]]; then
	export WSL_TRANSLATE_MNT='/mnt/c'
fi

# Script needs path as one and only CLI parameter, this may be changed to a read later
if [ "$#" -ne 1 ]; then
	echo "Usage: [WSL_TRANSLATE_FUNC=function] [WSL_TRANSLATE_MNT=windows mount location] $0 <windows path>"
	if [[ $sourced -eq 0 ]]; then
		return 1
	fi
	exit 1
fi

# Check for help command to display template message and available functions
case $1 in

	'help' | '--help' | '-h')
		echo "Usage: [WSL_TRANSLATE_FUNC=function] [WSL_TRANSLATE_MNT=windows mount location] $0 <windows path>"
		echo "Available functions stdout (default), cd, cp, ls, mkdir, mv, rm"
		echo "To use cd you must source the script with source $0 <path> or . $0 <path> to ensure the cd persists"
		if [[ $sourced -eq 0 ]]; then
			return 1
		fi
		exit 1
		;;
	*)
		# If not help parameter must be target path
		win_path=$1
esac

# Remove Drive letter and colon "C:"
path_driveless="${win_path#[A-Za-z]:}"
# Prepend mount point and flip slash directions
unix_path="${WSL_TRANSLATE_MNT}${path_driveless//\\//}"

# If using stdout for piping into arbitrary functions then the path should be the only thing printed
if [[ "$WSL_TRANSLATE_FUNC" ==  "stdout" ]]; then
	echo "$unix_path"
	if [[ $sourced -eq 0 ]]; then
		return 0
	fi
	exit 0
fi
echo "Using func: ${WSL_TRANSLATE_FUNC} at ${WSL_TRANSLATE_MNT}"
echo "Windows Path: ${win_path}"
echo "WSL Path: ${unix_path}"


printf "Continue to %s? [y/N] " "${WSL_TRANSLATE_FUNC}"
read -r response

case "$response" in
	[Yy][Ee][Ss]|[Yy])

		case $WSL_TRANSLATE_FUNC in

			'mv')
				printf "Destination: "
				read -r destination
				mv "$unix_path" "$destination"
				;;
			'cd')
				if [[ $sourced -ne 0 ]]; then
					echo "WARN: You have selected cd function without sourcing the script"
					echo "To use cd you must source the script with source $0 <path> or . $0 <path> to ensure the cd persists"
				fi
				cd "$unix_path"
				;;
			'touch')
				printf "File name: "
				read -r file
				touch "$unix_path/$file"
				;;
			'rm')
				rm -r "$unix_path"
				;;
			'mkdir')
				printf "Folder name: "
				read -r folder
				mkdir "$unix_path/$folder"
				;;
			'cp')
				printf "Destination: "
				read -r destination
				cp "$unix_path" "$destination"
				;;
			'ls')
				printf "Flags for ls (include and -'s and leave empty for none): "
				read -r flags
				ls $flags "$unix_path"
				;;

			*)
				echo "$WSL_TRANSLATE_FUNC is an unsupported function, please refer to the help menu or if your function supports piping use stdout function and pipe"
				if [[ $sourced -eq 0 ]]; then
					return 1
				fi
				exit 1
				;;
		esac
		if [[ $sourced -eq 0 ]]; then
			return 0
		fi
		exit 0
		;;

	# Any other response than yes
	*)
		if [[ $sourced -eq 0 ]]; then
			return 0
		fi
		exit 0
		;;
esac
