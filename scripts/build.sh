#!/usr/bin/env bash
echo -e "[build] starting build\n"
cd mercury || { echo -e "[build] [error] mercury directory not found, exiting\n" ; exit 1; }
pnpm build || { echo -e "[build] [error] build failed\n" ; echo -e "[build] cleaning up\n" ; cd .. && rm -rf ./mercury ; exit 1; }
cd ..
# move the output to make the deployment service use with Astro correctly
mv ./mercury/dist ./
echo -e "[build] done. be sure to set the build output dir to './dist'\n\n"
echo -e "[build] cleaning up\n"
rm -rf ./mercury
