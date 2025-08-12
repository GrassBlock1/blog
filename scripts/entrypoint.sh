#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ "$1" == '--copy-src-when-init' ]; then
	bash $SCRIPT_DIR/init.sh --also-copy-src
else
	bash $SCRIPT_DIR/init.sh
fi
if [ "$2" == "--copy-config-when-merge" ]; then
	bash $SCRIPT_DIR/merge.sh --copy
else
	bash $SCRIPT_DIR/merge.sh
fi
bash $SCRIPT_DIR/build.sh
