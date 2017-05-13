#!/bin/bash

# http://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination


if test "$1" = ""; then
    read -p "Entry Directory: " directory
    directory="${directory}/*/.git"
else
    directory="${1}/*/.git"
fi



for i in $(ls -d ${directory})
do
    echo ${i%%/.git}
    cd ${i%%/.git}
    git pull
    cd -
done
