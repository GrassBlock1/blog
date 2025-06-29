#!/usr/bin/env bash
echo "starting build"
cd mercury
pnpm build || (echo "build failed" && exit 1)
cd ..
# move the output to make the deployment service use with Astro correctly
mv ./mercury/dist ./
echo "done. be sure to set the build output dir to './dist'"
echo "cleaning up"
rm -rf ./mercury
