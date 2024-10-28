
#!/bin/bash

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

# Import variables from .env if variable is not set in the system
[[ -z "$MULTIPASS_PASSPHRASE" ]] && source .env