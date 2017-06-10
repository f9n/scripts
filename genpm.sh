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

function checking_necessary_packages {
  index=0
  # Checking lsb_release
  if ! which lsb_release >/dev/null 2>&1; then
    array[$index]="lsb_release"
    index=$index+1
  fi
  # Checking awk
  if ! which awk > /dev/null 2>&1; then
    array[$index]="awk"
    index=$index+1
  fi
  echo ${array[*]}
}

checking_necessary_packages
OS=$(lsb_release -a | awk '{if (NR==2) print $3}')
echo $OS
