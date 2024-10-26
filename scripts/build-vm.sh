#!/bin/bash

#======================================================================
# Script to build virtual machines
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#========================================================================

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