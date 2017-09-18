#!/usr/bin/env bash

for file in $(find . -name "updatefilelist.txt"); do
    filename=${file##*/} # Learn filename in string path
    path=${file%$filename}  # Learn up directory
    variable="filelist.txt"
    mv $file ${path}${variable}
done
