#!/bin/bash

# Color variables
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BOLD="\033[1m"
DEFAULT="\033[0m"

echo -e "${YELLOW}Commit message: ${NOCOLOR}"
read MSG

# Check if message is not empty
if [ -z "$MSG" ]; then
    echo -e "${RED}Commit message is required!"
    return
fi

hugo && cd ..

# Check if there is public folder
if [ ! -d "public" ]; then
    echo -e "${YELLOW}There is no public folder, trying to recreate..."
    mkdir public && cd public
    git clone git@github.com:lxhan/lxhan.github.io.git .
elif [ -d "public" ]; then
    cd public && git pull
    echo -e "${YELLOW}Changed directory to ${BOLD} $(pwd)"
    git add . && git commit -m "$MSG" && git push
else
    echo -e "${RED}Something wrong with the tree structure"
    return
fi

cd ../site
echo -e "${YELLOW}Changed directory to ${BOLD} $(pwd)"

# Push to hugo site
git add .
git commit -m "$MSG"
git push

echo -e "${GREEN}Deployment finished"
