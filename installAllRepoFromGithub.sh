#!/bin/bash

# ------------------------------------------------- #
# We are downloading source code in link.           #
# And created links.txt.                            #
# ------------------------------------------------- #

github="https://github.com/"
username="pleycpl"
query="?tab=repositories"
githubReposLink="${github}${username}${query}"
echo $githubReposLink
curl $githubReposLink | grep "<a href=\"/${username}/.*" > links.txt
cat links.txt

# ------------------------------------------------- #
# And then we strip pure link with awk.             #
# ------------------------------------------------- #

# ------------------------------------------------- #
# Finally we download all repos with git clone      #
# --------------------------------------------------#



