
#!/bin/bash

#======================================================================
# Collection of constants to use anywhere
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

readonly VIRTUAL_MACHINE_ENV_NAME='KUBERNETES_VM'
readonly NATO_CODES=(
    "alfa"
    "bravo"
    "charlie"
    "delta"
    "echo"
    "foxtrot"
    "golf"
    "hotel"
    "india"
    "juliett"
    "kilo"
    "lima"
    "mike"
    "november"
    "oscar"
    "papa"
    "quebec"
    "romeo"
    "sierra"
    "tango"
    "uniform"
    "victor"
    "whiskey"
    "x-ray"
    "yankee"
    "zulu"
)
readonly MAX_NUM_OF_VMS=${#NATO_CODES[@]}
readonly MULTIPASS_TOKEN=$MULTIPASS_TOKEN
