#!/usr/bin/env bash
### Global Variables
declare -A ALL_SITE_PACKAGES_PATHS=(
    ["py2"]="python2"
    ["py3"]="python3"
)
function init() {
    echo "[+] init function"
    ALL_SITE_PACKAGES_PATHS["py2"]=$(find $HOME -name site-packages -type d | grep 'python2' )
    ALL_SITE_PACKAGES_PATHS["py3"]=$(find $HOME -name site-packages -type d | grep 'python3' )
}
function print_site_packages_paths {
    local python_version=$1
    for Site_Packages_Path in ${ALL_SITE_PACKAGES_PATHS[$python_version]}; do
        echo ${Site_Packages_Path}
    done
}
function usage {
    echo "./main.sh <my_venv_path> <install|remove> <package_name>"
}
function main {
    local my_venv_path=$1
    local status=$2
    local package_name=$3
    init
    print_site_packages_paths py3
    echo $my_venv_path
    echo $status
    echo $package_name
}

main "$@"

