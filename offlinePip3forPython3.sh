#!/usr/bin/env bash
### Global Variables
declare -A ALL_SITE_PACKAGES_PATHS=(
    ["py2"]=""
    ["py3"]=""
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
    echo "./main.sh <py3|py2> <my_venv_path> <install|remove> <package_name>"
}
function main {
    local python_status=$1 # Like py3 or py2
    local my_venv_path=$2 # Currently, Please insert full path. Like /home/<user_name>/....
    local status=$3
    local package_name=$4 # We must learn sub packages this package_name.
    init
    print_site_packages_paths $python_status
}

main "$@"

