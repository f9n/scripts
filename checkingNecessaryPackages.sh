#!/bin/bash
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

  if [ -z "$missing_packages" ]; then
    echo "Everything is okey."
  else
    echo "You should install this packages:" ${missing_packages[*]}
  fi
}

# Main Section
index=0
missing_packages=("")
necessary_packages=("lsb_release" "awk")
checking_necessary_packages
