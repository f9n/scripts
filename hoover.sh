#!/usr/bin/env bash
# https://stackoverflow.com/questions/42950501/delete-node-modules-folder-recursively-from-a-specified-path-using-command-line

HOOVER_SEARCH_PATH="."
HOOVER_CONFIG_PATH="$HOME/.config/hoover"
HOOVER_ACTION="rm -rf"

function hoover_action() {
	local directory_name=$1
	find ${HOOVER_SEARCH_PATH} -name $directory_name -type d -prune -print -exec ${HOOVER_ACTION} '{}' +
}

function hoover_main() {
	local arg_path=$1
	shift
	local arg_action=$@
	[[ ! $arg_path == "" ]] && HOOVER_SEARCH_PATH=$arg_path
	[[ ! $arg_action == "" ]] && HOOVER_ACTION=$arg_action
	for directory_name in $(cat ${HOOVER_CONFIG_PATH}); do
		hoover_action $directory_name
	done
}

hoover_main "$@"
