#!/bin/bash
# bash script mode

function exit() { echo -e "\n$0:${BASH_LINENO[0]} '$BASH_COMMAND' failed" >&2; }

trap exit ERR
set -eoa pipefail
