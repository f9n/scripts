#!/bin/bash

# http://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination
for i in $(ls -d */.git)
do 
    echo ${i%%/.git}
    cd ${i%%/.git}
    git pull
    cd ..
done