#!/bin/bash

FILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
FRAMEWORK_DIR="${FILE_DIR/scripts/framework}"
source $FRAMEWORK_DIR/generic/functions.sh || exit 1

# Checks and options handler
g_importpackage_handler multipass --install
vm_args_parser "$@"

multipass transfer install_package.sh vm1:/tmp/install_package.sh
multipass run alfa -- /tmp/install_package.sh