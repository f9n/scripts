#!/usr/bin/env bash

for file in $(find . -name "updatefilelist.txt"); do
    filename=${file##*/} # Learn filename in string path,   filename=$(basename $file)
    path=${file%$filename}  # Learn up directory            updirname=$(dirname $file)
    variable="filelist.txt"
    mv $file ${path}${variable}
done
