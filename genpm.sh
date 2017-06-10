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

which lsb_release > /dev/null 2>&1 || { echo "We require lsb_release but it's not installed."; exit 1; }
OS=$(lsb_release -a | awk '{if (NR==2) print $3}')
echo $OS
