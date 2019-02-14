#!/bin/bash

echo "Commit message:"
read MSG

# Check if message is not empty
if [ -z "$MSG" ]; then
    echo "Commit message is required!"
    return
fi

hugo && cd ..

# Check if there is public folder
if [ ! -d "public" ]; then
    echo "There is no public folder, trying to recreate..."
    mkdir public && cd public
    git clone git@github.com:lxhan/lxhan.github.io.git .
elif [ -d "public" ]; then
    cd public && git pull
    echo "Changed directory to $(pwd)"
    git add . && git commit -m "$MSG" && git push
else
    echo "Something wrong with the tree structure"
    return
fi

cd ../site
echo "Changed directory to $(pwd)"

# Push to hugo site
git add .
git commit -m "$MSG"
git push

echo "Deployment finished"
