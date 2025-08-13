#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Get the parent directory by changing directory and printing the path
PARENT_DIR=$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )
if [[ "$1" != "--copy" && -f "$PARENT_DIR/config/config.ts" ]]; then
	echo -e "[merge] merge config start\n"
    pnpm start "$PARENT_DIR/mercury/src/config.ts" siteConfig siteConfig "$PARENT_DIR/mercury/src/config.ts" "$PARENT_DIR/config/config.ts"
	echo -e "[merge] merge config done\n"
elif [[ "$1" == "--copy" && -f "$PARENT_DIR/config/config.ts" && ! -f "$PARENT_DIR/overrides/config.ts" ]]; then
	echo -e "[merge] copy mode enabled, so we are copying files instead\n"
	cp $PARENT_DIR/config/config.ts "$PARENT_DIR/mercury/src/config.ts"
fi
