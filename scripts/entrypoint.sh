#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
args=("$@")
if [ "${args[0]}" == '--copy-src-when-init' ]; then
	bash $SCRIPT_DIR/init.sh --also-copy-src
else
	bash $SCRIPT_DIR/init.sh
fi
if [ "${args[1]}" == '--copy-config-when-merge' ]; then
	bash $SCRIPT_DIR/merge.sh
else
	bash $SCRIPT_DIR/merge.sh
fi
bash $SCRIPT_DIR/build.sh
