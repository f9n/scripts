#!/bin/bash

# ------------------------------------------------- #
# We are downloading source code in link.           #
# And created allAtags.txt.                         #
# ------------------------------------------------- #
downloadLinks() {
    echo -e "[+] Starting downloadLinks function"
    github="https://github.com"
    username="pleycpl"
    pageSize=$1
    touch allAtags.txt
    for page in $(seq ${pageSize})
    do
        echo -e "[+] Page ${page} crawling."
        query="?page=${page}&tab=repositories"
        githubReposLink="${github}/${username}${query}"
        #echo $githubReposLink
        curl $githubReposLink | grep "<a href=\"/${username}/.*" >> allAtags.txt
        echo -e ""
    done
    echo -e "[+] All tags"
    cat allAtags.txt
}

# ------------------------------------------------- #
# And then we strip pure link with awk.             #
# ------------------------------------------------- #
cleanLinks() {
    echo -e "[+] Starting cleanLinks function"
    awk -F"\"" '{print $2}' allAtags.txt > pureLinks.txt
    echo -e "[+] Pure Links"
    cat pureLinks.txt
}

# ------------------------------------------------- #
# Adding host name and protocol to links!           #
# ------------------------------------------------- #
addedProtocolAndHostname() {
    echo -e "[+] Starting addedProtocolAndHostname function"
    replaceString=".*"
    replaceWith="${github}&"
    sed s~$replaceString~$replaceWith~ < pureLinks.txt > pure.txt
    echo -e "[+] Links with Protocol and Hostname"
    cat pure.txt
}

# ------------------------------------------------- #
# Finally we download all repos with git clone      #
# --------------------------------------------------#
downloadRepos() {
    echo -e "[+] Downloading repos...\n"
    for f in `cat pure.txt`
    do
        git clone $f
    done
}

Main() {
    read -p "Entry your github repository page size: " size
    downloadLinks $size
    cleanLinks
    addedProtocolAndHostname
    downloadRepos
}

Main

