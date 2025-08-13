#!/usr/bin/env bash
echo -e "[init] cloning repo\n"
git clone https://github.com/GrassBlock1/mercury ./mercury
echo -e "[init] removing unnecessary files\n"
# emptying content files without deleting config files
find ./mercury/src/content/pages ! -name '_schemas.ts' -type f -exec rm -r {} +
find ./mercury/src/content/posts ! -name '_schemas.ts' -type f -exec rm -r {} +
rm -r ./mercury/.idea
rm -r ./mercury/.vscode
echo -e "[init] copying files\n"
# check the directory exists first
if [ -n "$(ls -A ./assets 2>/dev/null)" ]; then
    cp -r ./assets/. ./mercury/src/assets/ 2>/dev/null
else
    echo "assets directory does not exist, skipping"
fi
if [ -n "$(ls -A ./content 2>/dev/null)" ]; then
    cp -r ./content/. ./mercury/src/content/ 2>/dev/null
else
    echo "content directory does not exist, skipping"
fi
if [ -n "$(ls -A ./public 2>/dev/null)" ]; then
    mkdir ./mercury/public && cp ./public/. ./mercury/public/ 2>/dev/null
else
    echo "public directory does not exist, skipping"
fi
if [[ "$1" == "--also-copy-src" && -n "$(ls -A ./overrides 2>/dev/null)" ]]; then
    echo -e "[init] copying overrides\n"
    if type rsync > /dev/null; then
        # ask install async here
        rsync -av --progress ./overrides/ ./mercury/src
    else
        cp -r ./overrides/. ./mercury/src
    fi
fi
echo -e "[init] installing dependencies\n"
if ! type pnpm > /dev/null; then
  # ask install pnpm here
  echo -e "[init] [error] you need to install pnpm to continue\n" && exit 1
fi
# install the dependencies of the project
pnpm i
# install the dependencies of the theme
cd mercury && pnpm i
echo "init stage done"
