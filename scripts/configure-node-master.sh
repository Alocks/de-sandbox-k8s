#!/bin/bash
FILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
FRAMEWORK_DIR="${FILE_DIR/scripts/framework}"

# Modules
source $FRAMEWORK_DIR/generic/functions.sh || exit 1
source $FRAMEWORK_DIR/generic/constants.sh || exit 1

# Checks and options handler
g_importpackage_handler multipass --install
g_importpackage_handler microk8s --install
g_importpackage_handler lxd --install

multipass set local.passphrase=$MULTIPASS_PASSPHRASE
multipass set local.driver=lxd
