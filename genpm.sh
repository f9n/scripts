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
# https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
function available_package_management_tools {
  index=0
  case `uname` in
    Linux )
       which apt-get  > /dev/null 2>&1 && { pm[$index]="apt-get" ; index=$index+1; }
       which pacman   > /dev/null 2>&1 && { pm[$index]="pacman"  ; index=$index+1; }
       which dnf      > /dev/null 2>&1 && { pm[$index]="dnf"     ; index=$index+1; }
       which yum      > /dev/null 2>&1 && { pm[$index]="yum"     ; index=$index+1; }
       ;;
    Darwin )
       ;;
    * )
       # Handle AmgiaOS, CPM, and modified cable modems here.
       ;;
  esac
}

pm=("")
file="/home/$(echo ${USER})/.genpmrc"
if [ -f "$file" ]
then
	echo "$file found."
else
  echo "Created .genpmrc file!"
  touch $file
  available_package_management_tools
  echo $pm > $file
fi
