#!/bin/bash

# ------------------------------------------------- #
# We are downloading source code in link.           #
# And created allAtags.txt.                         #
# ------------------------------------------------- #
downloadLinks() {
    echo -n "[+] Starting downloadLinks function"
    github="https://github.com"
    username="pleycpl"
    query="?tab=repositories"
    githubReposLink="${github}/${username}${query}"
    echo $githubReposLink
    curl $githubReposLink | grep "<a href=\"/${username}/.*" > allAtags.txt
    cat allAtags.txt
}

# ------------------------------------------------- #
# And then we strip pure link with awk.             #
# ------------------------------------------------- #
cleanLinks() {
    echo -n "[+] Starting cleanLinks function"
    awk -F"\"" '{print $2}' allAtags.txt > pureLinks.txt
    cat pureLinks.txt
}

# ------------------------------------------------- #
# Adding host name and protocol to links!           #
# ------------------------------------------------- #
addedProtocolAndHostname() {
    echo -n "[+] Starting addedProtocolAndHostname function"
    replaceString=".*"
    replaceWith="${github}&"
    sed s~$replaceString~$replaceWith~ < pureLinks.txt > pure.txt
    cat pure.txt
}

# ------------------------------------------------- #
# Finally we download all repos with git clone      #
# --------------------------------------------------#
downloadRepos() {
    echo -n "[+] Downloading repos..."
    for f in `cat pure.txt`
    do
        git clone $f
    done
}

Main() {
    downloadLinks
    cleanLinks
    addedProtocolAndHostname
    downloadRepos
}

Main

