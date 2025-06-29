#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
bash $SCRIPT_DIR/init.sh
bash $SCRIPT_DIR/merge.sh
bash $SCRIPT_DIR/build.sh
