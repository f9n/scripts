#!/bin/bash
# We are using these tutorials:
# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
# https://www.linode.com/docs/tools-reference/linux-package-management/
# https://en.0wikipedia.org/index.php?q=aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvTGlzdF9vZl9zb2Z0d2FyZV9wYWNrYWdlX21hbmFnZW1lbnRfc3lzdGVtcw

# ------------------------------------------- #
# General package manager (genpm)             #
# For now, we supported unix-like os.         #
# Inclusive of Tools                          #
### Linux                                     #
# Arch based    : pacman                      #
# Debian based  : apt-get                     #
# Rpm based     : yum                         #
# Fedora based  : dnf                         #
### Bsd                                       #
# FreeBsd based : pkg                         #
### Apple                                     #
# macOs : homebrew                            #
# ------------------------------------------- #

# ------------------------------------------- #
##########    Genpm Command Lists    ##########
# $ genpm install <pkg_name>                  #
# $ genpm remove <pkg_name>                   #
# $ genpm search <search_string>              #
# ------------------------------------------- #

##########    Genpm Code Section ##############
# Functions Section
# https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
function available_package_management_tools {
  index=0
  case `uname` in
    Linux )
       which apt-get  > /dev/null 2>&1 && { PMS[$index]="aptget"  ; index=$index+1; }
       which pacman   > /dev/null 2>&1 && { PMS[$index]="pacman"  ; index=$index+1; }
       which dnf      > /dev/null 2>&1 && { PMS[$index]="dnf"     ; index=$index+1; }
       which yum      > /dev/null 2>&1 && { PMS[$index]="yum"     ; index=$index+1; }
       ;;
    Darwin )
       ;;
    * )
       # Handle AmgiaOS, CPM, and modified cable modems here.
       ;;
  esac
}

function reload_genpmrc {
  touch $FILEPATH
  available_package_management_tools
  echo $PMS > $FILEPATH
}

function check_genpmrc {
  if [ ! -f "$FILEPATH" ]
  then
    echo "Created .genpmrc file!"
    reload_genpmrc
  fi
}

function install {
  echo "Install package"
}

function search {
  echo "Search package"
}

function remove {
  echo "Remove package"
}

FILEPATH="/home/$(echo ${USER})/.genpmrc"
PMS=("")        # All package management tools in current os
if [ "$1" == "" ] || [ "$2" == "" ]; then
  echo "Please insert at less two arguman, like: genpm install <package_name>"
  exit 1
fi
ARGUMAN=$1      # Like install, remove, search
PACKAGENAME=$2  # Like awk, sed
check_genpmrc   # .genpmrc file is exist?
TOOL=$(cat ${FILEPATH} | sed -e 's/ //g')
echo $TOOL
echo $ARGUMAN
$ARGUMAN        # Runned ARGUMAN name function
