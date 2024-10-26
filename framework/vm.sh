#!/bin/bash

#======================================================================
# Library for creation and managment of virtual Machines
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
FILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$FILE_DIR/generic/constants.sh" || exit 1

g_package_handler --package=multipass --raise=error

# Global variables
declare VM_QTY
declare VM_CPUS
declare VM_MEMORY
declare VM_DISK

# Documentation for build-vm.sh
function vm_usage {
  echo "Usage: ./build-vm.sh --vm_qty=5 --cpus=2 --memory=4G --disk=20G"
  echo "Options:"
  echo "  --vm_qty  Quantity of virtual machines to create"
  echo "  --cpus    vCPU quantity for the VMs being created"
  echo "  --memory  Memory size for the VMs being created"
  echo "  --disk    Disk size for the VMs being created"
  exit 0
}

# Error handler for vm_args_parser
function vm_error_handler() {
    if [[ -z "$VM_QTY" || -z "$VM_CPUS" || -z "$VM_MEMORY" || -z "$VM_DISK" ]]; then
        echo "vm $VM_QTY cpu $VM_CPUS memory $VM_MEMORY disk $VM_DISK"
        echo "Missing required arguments."
        vm_usage
        exit 1
    elif [[ VM_QTY -gt MAX_NUM_OF_VMS ]]; then
        echo "Can only configure a maximum of $MAX_NUM_OF_VMS virtual machines! If you need more, add string in nato_codes array inside the script."
        exit 1
    else
        echo "Creating Virtual Machines..."
    fi
}

#Options parser for build-vm !Deppends on vm_error_handler 
function vm_args_parser() { 
    local OPTIND=1     
    local optspec=":hv-:"

    while getopts $optspec optchar; do
      case $optchar in
        -)
        case ${OPTARG} in
          vm_qty)
            echo "Value not set for vm_qty"
            exit 0
            ;;
          vm_qty=*[0-9])
            VM_QTY=${OPTARG#*=}
            ;;
          cpus)
            echo "Value not set for cpus"
            ;;
          cpus=*[0-9])
            VM_CPUS=${OPTARG#*=}
            ;;
          memory)
            echo "Value not set for memory"
            ;;
          memory=*[0-9]G)
            VM_MEMORY=${OPTARG#*=}
            ;;
          disk)
            echo "Value not set for disk"
            ;;
          disk=*[0-9]G)
            VM_DISK=${OPTARG#*=}
            ;;
          help)
            vm_usage
            exit 0
            ;;
          *)
            if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
              echo "Unknown or invalid argument --${OPTARG}"
            fi
            ;;
        esac
        ;;
        *)
          if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
              echo "Unknown argument: '-${OPTARG}'"
          fi
          ;;
      esac
    done
    
    vm_error_handler
}

# Set VM name using NATO_CODES array
function vm_set_virtual_machine() {
  aux=$VIRTUAL_MACHINE_ENV_NAME$(($1+1))
  export $aux=${NATO_CODES[$1]}
  eval current_vm_name=\$$aux
  if multipass list | grep -q "$current_vm_name"; then
    echo "$current_vm_name already exists."
  else
    echo "$current_vm_name $CPUS $MEMORY$DISK"
    #multipass launch --name $current_vm_name --cpus $VM_CPUS --memory $VM_MEMORY --disk $VM_DISK
  fi
}