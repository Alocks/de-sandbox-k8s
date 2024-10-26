
#!/bin/bash

#======================================================================
# Collection of generic functions to use anywhere
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

function g_is_user_root() {
   if [[ $EUID -ne 0 ]]; then
      echo "You are not root! Please, run as root!"
      exit 1
   fi
}

function g_is_package_avaible() {
   if command -v $1 >/dev/null 2>&1; then
      return 0 # true
   else
      return 1 # false
   fi
}

function g_import() {
   for arg in "$@"; do
      if [[ -f "$arg.sh" ]]; then
         source "$arg.sh"
      else
         echo "Failed to import $arg.sh. Exiting..."
         exit 1
      fi
   done
}

# Depends on is g_package_avaible
function g_package_handler() {
   local optspec=":hv-:"
   local usage="Usage: ./functions.sh --install --raise=error
               \nOptions:
               \n--package          Package name
               \n--inst(optional)   Install package if not avaible
               \n--raise(optional)  Raises a selected option. Type './functions.sh --raise' for more information"
   local install=0
   local raise_error=0
   local raise_message=0

   while getopts "$optspec" optchar; do
      case "${optchar}" in
         -)
         case "${OPTARG}" in
            package)
               echo "--package usage:"
               echo "   package={package_name}"
               exit 0
               ;;
            package=*)
               package_name=${OPTARG#*=}
               ;;
            install)
               install=1
               ;;
            raise)
               echo "--raise Options:"
               echo "  error    Raise an exception and exits"
               echo "  message  Prints a message in  terminal"
               exit 0
               ;;
            raise=error)
               raise_error=1
               ;;
            raise=message)
               raise_message=1
               ;;
            help)
               echo -e $usage | sed 's/^ *//g'
               exit 0
               ;;
            *)
               if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                  echo "Invalid argument --${OPTARG}" >&2
                  echo -e $usage | sed 's/^ *//g'
                  exit 1
               fi
               ;;
         esac;;
         *)
         if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
            echo "Invalid argument: '-${OPTARG}'" >&2
            echo -e $usage | sed 's/^ *//g'
            exit 1
         fi
         ;;
      esac
   done
   
   if [[ -z "$package_name" ]]; then
      echo "Error:: Must set package name"
      exit 1
   fi

   g_is_package_avaible $package_name
   is_avaible=$?
   if [[ "$is_avaible" -eq 1 ]]; then
   
      if [[ install -eq 1 ]]; then
         sudo snap install $package_name
         exit 0
      # --raise h
      andler
      elif [[ $"raise_error" -eq 1 || $"raise_message" -eq 1 ]]; then
         echo "Error:: $package_name is not installed!"
         [[ $"raise_error" -eq 1 ]] && exit 1
      else  
         return $is_avaible
      fi
   fi
   
   return $is_avaible
}