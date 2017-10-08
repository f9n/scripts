#!/usr/bin/env bash
### Global Variables
declare -A All_SitePackages_Paths=(
    ["py2"]="python2"
    ["py3"]="python3"
)
function init() {
    echo "[+] init function"
    All_SitePackages_Paths["py2"]=$(find $HOME -name site-packages -type d | grep 'python2' )
    All_SitePackages_Paths["py3"]=$(find $HOME -name site-packages -type d | grep 'python3' )
}
function print_site_packages_paths {
    local python_version=$1
    for SitePackages in ${All_SitePackages_Paths[$python_version]}; do
        echo ${SitePackages}
    done
}
function main {
    init
    print_site_packages_paths py3
}

main "$@"
