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
function check_package {
  # $1 is package name
  if ! which $1 > /dev/null 2>&1; then
    # Package is not exists.
    missing_packages[$index]="$1"
    index=$index+1
  fi
}

function checking_necessary_packages {
  for package in "${necessary_packages[@]}"
  do
    check_package $package
  done
  echo ${missing_packages[*]}
}

# Main Section
index=0
missing_packages[$index]=""
necessary_packages=("lsb_releaseA" "Aawk")
checking_necessary_packages
OS=$(lsb_release -a | awk '{if (NR==2) print $3}')
echo $OS
