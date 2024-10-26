#!/bin/bash

FILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
FRAMEWORK_DIR="${FILE_DIR/scripts/framework}"
source $FRAMEWORK_DIR/generic/functions.sh || exit 1
source $FRAMEWORK_DIR/vm.sh || exit 1
# Checks and options handler
g_package_handler --package=multipass --install
vm_args_parser "$@"

# Execute commands to set virtual machine(s) and global variables in the host
for (( i=0; i < $VM_QTY; i++ )); do
  vm_set_virtual_machine $i
done