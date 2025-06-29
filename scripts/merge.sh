#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Get the parent directory by changing directory and printing the path
PARENT_DIR=$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )
echo "merge config start"
pnpm start "$PARENT_DIR/mercury/src/config.ts" siteConfig siteConfig "$PARENT_DIR/mercury/src/config.ts" "$PARENT_DIR/config/config.ts"
echo "merge config done"
