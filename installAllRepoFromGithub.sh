#!/bin/bash

# ------------------------------------------------- #
# We are downloading source code in link.           #
# And created allAtags.txt.                         #
# ------------------------------------------------- #
github="https://github.com"
username="pleycpl"
query="?tab=repositories"
githubReposLink="${github}/${username}${query}"
echo $githubReposLink
curl $githubReposLink | grep "<a href=\"/${username}/.*" > allAtags.txt
cat allAtags.txt

# ------------------------------------------------- #
# And then we strip pure link with awk.             #
# ------------------------------------------------- #
awk -F"\"" '{print $2}' allAtags.txt > pureLinks.txt
cat pureLinks.txt

# ------------------------------------------------- #
# Adding host name and protocol to links!           #
# ------------------------------------------------- #
replace_string=".*"
replace_with="${github}&"
sed s~$replace_string~$replace_with~ < pureLinks.txt > pure.txt
cat pure.txt

# ------------------------------------------------- #
# Finally we download all repos with git clone      #
# --------------------------------------------------#
for f in `cat pure.txt`
do
    git clone $f
done


