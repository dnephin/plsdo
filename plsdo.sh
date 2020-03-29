#!/usr/bin/env bash
# plsdo.sh
# version 0.1.0
set -o errexit -o nounset -o pipefail

list() {
    declare -F | awk '{print $3}' | grep -v '^_'
}

declare -A help

_plsdo_help() {
    local topic="${1-}"
    if [[ -n "$topic" ]]; then
        if ! command -v "$topic" > /dev/null ; then
            echo "No such task: $topic"
            return 1
        fi

        local text="${help[$topic]-}"
        printf "\nUsage:\n  $0 $topic\n\n$text"
        return 0
    fi

    [ -n "${banner-}" ] && echo "$banner" && echo
    for i in $(list); do
        printf "%-20s\t%s\n" $i "${help[$i]-}" | head -1
    done
}

# TODO: where to call this?
_plsdo_check_bin_in_path() {
    bins=( awk grep head printf )
    for b in "${bins[@]}"; do
        command -v "$b" || echo "Missing $b in \$PATH";
    done
}

_plsdo() {
    case "${1-}" in
        ""|help) _plsdo_help "${2-}";;
        *)  "$@";;
    esac
}

