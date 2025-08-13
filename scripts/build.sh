#!/usr/bin/env bash
echo -e "[build] starting build\n"
cd mercury || { echo -e "[build] [error] mercury directory not found, exiting\n" ; exit 1; }
pnpm build || { echo -e "[build] [error] build failed\n" ; echo -e "[build] cleaning up\n" ; cd .. && rm -rf ./mercury ; exit 1; }
echo -e "[build] done. be sure to set the build output dir to './dist'\n\n"
echo -e "[build] cleaning up\n"
# 删除除了 dist 之外的所有内容
find . -maxdepth 1 ! -name "." ! -name "dist" -exec rm -rf {} +
