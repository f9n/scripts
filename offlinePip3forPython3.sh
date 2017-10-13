#!/usr/bin/env bash
### Global Variables
declare -A ALL_SITE_PACKAGES_PATHS=(
    ["py2"]=""
    ["py3"]=""
)
declare -a InitialFiles=("")
REQUIRE_PACKAGES=""
IS_DEBUG="FALSE"
SETUPPATH="$HOME/offlinepip3"

function check_is_debug_mode() {
    local string=$1
    [ $IS_DEBUG = "TRUE" ] && echo "[+] $string" 
}

function init() {
    # Set up global arrays, finding all py3 or py2 site-packages path 
    check_is_debug_mode "init function"
    ALL_SITE_PACKAGES_PATHS["py2"]=$(find $HOME -name site-packages -type d | grep 'python2' 2>/dev/null)
    ALL_SITE_PACKAGES_PATHS["py3"]=$(find $HOME -name site-packages -type d | grep 'python3' 2>/dev/null)
}
function print_site_packages_paths {
    # printing "site_packages" paths in global ALL_SITE_PACKAGES_PATHS for python version
    local python_version=$1
    check_is_debug_mode "print_site_packages_paths() python_version: $python_version"
    for Site_Packages_Path in ${ALL_SITE_PACKAGES_PATHS[$python_version]}; do
        echo ${Site_Packages_Path}
    done
}
function usage {
    # bash offlinePip3forPython3.sh py3 ~/venv install telepot
    # bash offlinePip3forPython3.sh py3 ~/venv install telepot --debug
    echo "./main.sh <py3|py2> <my_venv_path> <install|remove> <package_name>"
}

function read_init_files {
    # reading virtualenv's init files
    local path=$SETUPPATH/venv/lib/python3*/site-packages
    check_is_debug_mode "read_init_files path: $path"
    virtualenv $SETUPPATH/venv > /dev/null 2>&1
    for initial_file in $(ls $path); do
        InitialFiles+=($initial_file)
    done
}

function read_downloaded_packages_in_site_packages {
    local path=$1
    local outputfile=$2
    check_is_debug_mode "read_downloaded_packages_in_site_packages() path: $path outputfile: $outputfile"
    for file in $(ls $path); do
        [[ "${InitialFiles[@]}" == *"$file"* ]] && continue # if it is init file, it doesn't adding "packagelist_py2.txt" or "packagelist_py3.txt" file
        echo $file ${path}/${file} >> $outputfile
    done
}
function read_all_package_path {
    local python_version=$1
    check_is_debug_mode "read_all_package_path, python_version: $python_version"
    for Site_Packages_Path in ${ALL_SITE_PACKAGES_PATHS[$python_version]}; do
        # path of all package in "site_packages" is adding to "packagelist_py2.txt" or "packagelist_py3.txt" file.
        read_downloaded_packages_in_site_packages $Site_Packages_Path $SETUPPATH/packagelist_${python_version}.txt
    done
}

function get_require_packages() {
    local package_dist_info_path=$1 # Example data: /home/<user_name>venv/lib/python3.6/site-packages/Flask-0.12.2.dist-info
    # There is metadata.json in every "*dist.info" directory. And metadata.json file keep require packages.
    echo $package_dist_info_path
    # control, 'run_requires' key.
    # "run_requires": [{"requires": ["Babel (>=0.8)"], "extra": "i18n"}, {"requires": ["MarkupSafe (>=0.23)"]}]
    # then, i have just markupsafe
    REQUIRE_PACKAGES=$(cat $package_dist_info_path/metadata.json | python3 -c "import sys, json; print(*json.load(sys.stdin)['run_requires'][0]['requires'])")
}

function install {
    # installing package
    local python_status=$1
    local package_name=$2
    local package_version=$3
    local targetvenvpath=$4
    local package_dist_info=""
    local package_dist_info_path=""
    check_is_debug_mode "install() package_name: $package_name python_version: $python_version"

    ## packagelist_py3.txt - Content
    #       ...
    #       flask /home/<user_name>/venv/lib/python3.6/site-packages/flask
    #       Flask-0.12.2.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/Flask-0.12.2.dist-info
    #       flask_mysqldb /home/<user_name>venv/lib/python3.6/site-packages/flask_mysqldb
    #       Flask_MySQLdb-0.2.0.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/Flask_MySQLdb-0.2.0.dist-info
    #       ...
    #       urllib3 /home/<user_name>/venv/lib/python3.6/site-packages/urllib3
    #       urllib3-1.21.1.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/urllib3-1.21.1.dist-info
    #       wheel-0.29.0.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/wheel-0.29.0.dist-info
    #       yarl /home/<user_name>/venv/lib/python3.6/site-packages/yarl
    #       yarl-0.10.2.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/yarl-0.10.2.dist-info
    #       ...
    # First with awk and grep - Content , we are searchin without path, because maybe package_name match path
    #       5 Flask-0.12.2.dist-info
    #       159 Flask-0.12.2.dist-info
    # Again with awk, returning line number
    #       5
    #       159
    # In for loop, with sed. Finding filename and path with lineno. And every line data is adding
    #       Flask-0.12.2.dist-info /home/<user_name>/github/heyiya/venv/lib/python3.6/site-packages/Flask-0.12.2.dist-info
    #       Flask-0.12.2.dist-info /home/<user_name>/venv/lib/python3.6/site-packages/Flask-0.12.2.dist-info
    # After that, we are finding big one.
    for lineno in $( awk '{ print NR, $1}' $SETUPPATH/packagelist_${python_status}.txt |\
                    grep -i "$package_name[-_][0-9.]*\.dist-info" |\
                    awk '{ print $1 }'); do
        sed "${lineno}q;d" $SETUPPATH/packagelist_${python_status}.txt >> $SETUPPATH/result_package_path.txt
        #awk -v n=$lineno 'NR == n' $SETUPPATH/packagelist_${python_version}.txt >> $SETUPPATH/result_package_path.txt
    done
    # Control, "result_package_path.txt"
    read -r package_dist_info package_dist_info_path <<< $(cat $SETUPPATH/result_package_path.txt | sort -r | head -n 1)
    get_require_packages $package_dist_info_path
    echo $REQUIRE_PACKAGES # Jinja2 (>=2.4) Werkzeug (>=0.7) click (>=2.0) itsdangerous (>=0.21)
    if [[ $REQUIRE_PACKAGES != "" ]]; then
        local flag=0
        local require_packagename=""
        local require_packageversion=""
        for require_packageNameOrVersion in $REQUIRE_PACKAGES; do
            if [[ "$flag" == "0" ]]; then
                flag="1"
                require_packagename=$require_packageNameOrVersion
            else
                flag="0"
                require_packageversion=$require_packageNameOrVersion
                echo $require_packagename $require_packageversion > $SETUPPATH/require_packages.txt
                install $python_status $require_packagename $require_packageversion $targetvenvpath
            fi
        done
    else
        echo "Not exists require package"
    fi
}
function main {
    local python_status=$1  # Like py3 or py2
    local my_venv_path=$2   # Currently, Please insert full path. Like /home/<user_name>/....
    local status=$3         # "install" or "remove" 
    local package_name=$4   # package_name.
    local debug=$5          # "--debug" or nothing
    [[ $debug = "--debug" ]] && IS_DEBUG="TRUE"
    [ ! -e $SETUPPATH ] && mkdir $SETUPPATH && check_is_debug_mode "created $SETUPPATH"
    rm $SETUPPATH/packagelist_py2.txt $SETUPPATH/packagelist_py3.txt 2> /dev/null
    rm $SETUPPATH/result_package_path.txt 2> /dev/null
    rm -r $SETUPPATH/venv 2> /dev/null
    
    init
    print_site_packages_paths $python_status
    read_init_files
    check_is_debug_mode ${InitialFiles[@]}
    read_all_package_path $python_status
    install $python_status $package_name "" $my_venv_path
}

main "$@"

# Python Packages
# ...../site-packages/<package_name>
# ...../site-packages/<package_name>-<version>.dist-info
# flask             Flask-0.12.2.dist-info
# itsdangerous.py   itsdangerous-0.24.dist-info
# flask_mysqldb     Flask_MySQLdb-0.2.0.dist-info
# markupsafe        MarkupSafe-1.0.dist-info
# jinja2            Jinja2-2.9.6.dist-info
# click             click-6.7.dist-info
