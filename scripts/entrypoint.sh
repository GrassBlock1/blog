#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "----- initializing project -----"
bash $SCRIPT_DIR/restore-time-from-git.sh
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
if ! bash $SCRIPT_DIR/build.sh; then
    echo "----- building site failed -----"
    exit 1
fi
echo "----- building site done -----"
