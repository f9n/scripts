#!/bin/bash

# ------------------------------------------------- #
# We are downloading source code in link.           #
# And created allAtags.txt.                         #
# ------------------------------------------------- #
github="https://github.com/"
username="pleycpl"
query="?tab=repositories"
githubReposLink="${github}${username}${query}"
echo $githubReposLink
curl $githubReposLink | grep "<a href=\"/${username}/.*" > allAtags.txt
cat allAtags.txt

# ------------------------------------------------- #
# And then we strip pure link with awk.             #
# ------------------------------------------------- #
awk -F"\"" '{print $2}' allAtags.txt > pureLinks.txt
cat pureLinks.txt

# ------------------------------------------------- #
# Finally we download all repos with git clone      #
# --------------------------------------------------#



