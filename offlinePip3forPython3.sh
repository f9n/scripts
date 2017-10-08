#!/usr/bin/env bash

All_Py2_SitePackages_PATHS=""
All_Py3_SitePackages_PATHS=""

function init() {
    echo "[+] init function"
    All_Py2_SitePackages_PATHS=$(find $HOME -name site-packages -type d | grep 'python2' )
    All_Py3_SitePackages_PATHS=$(find $HOME -name site-packages -type d | grep 'python3' )
}
function get_py2_site_packages_paths {
    echo "Python2"
    for SitePackages in ${All_Py2_SitePackages_PATHS}; do
        echo ${SitePackages}
    done
}
function get_py3_site_packages_paths {
    echo "Python3"
    for SitePackages in ${All_Py3_SitePackages_PATHS}; do
        echo ${SitePackages}
    done
}

function main {
    init
    get_py2_site_packages_paths
    get_py3_site_packages_paths
}

main "$@"
