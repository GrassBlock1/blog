#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "----- initializing project -----"
if [ "$1" == '--copy-src-when-init' ]; then
	bash $SCRIPT_DIR/init.sh --also-copy-src
else
	bash $SCRIPT_DIR/init.sh
fi
echo "----- init stage done -----"
echo "----- merging configs -----"
if [ "$2" == "--copy-config-when-merge" ]; then
	bash $SCRIPT_DIR/merge.sh --copy
else
	bash $SCRIPT_DIR/merge.sh
fi
echo "----- merging configs done -----"
echo "----- building site -----"
bash $SCRIPT_DIR/build.sh
echo "----- building site done -----"
