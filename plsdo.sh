#!/usr/bin/env bash
# plsdo.sh
# version 0.1.0
set -o errexit -o nounset -o pipefail

if [[ -n "${DEBUG-}" ]]; then
    set -o xtrace
fi

list() {
    declare -F | awk '{print $3}' | grep -v '^_'
}

help() {
    [ -n "${banner-}" ] && echo "$banner" && echo
    # TODO: include help text
    list
    echo
    echo "$help"
}

# TODO: where to call this?
_plsdo_check_bin_in_path() {
    bins=( awk grep )
    for b in "${bins[@]}"; do
        command -v "$b" || echo "Missing $b in \$PATH";
    done
}

_plsdo() {
    local help="${help-}"
    local banner="${banner-}"

    case "${1-}" in
    "") help "$banner";;
    *)  "$@";;
    esac
}

declare -A help
