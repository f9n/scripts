#!/usr/bin/env bash

All_Py2_SitePackages=$(find $HOME -name site-packages -type d | grep 'python2' )
All_Py3_SitePackages=$(find $HOME -name site-packages -type d | grep 'python3' )

echo "Python2"
for SitePackages in ${All_Py2_SitePackages}; do
    echo ${SitePackages}
done

echo "Python3"
for SitePackages in ${All_Py3_SitePackages}; do
    echo ${SitePackages}
done

