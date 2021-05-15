#!/usr/bin/env bash
# plsdo.sh, version 0.1.1
set -o errexit -o nounset -o pipefail

declare -A help

_plsdo_run() {
    case "${1-}" in
    ""|help)  _plsdo_help "${2-}" ;;
    *)        "$@" ;;
    esac
}

help[list]="Print the list of tasks"
list() {
    declare -F | awk '{print $3}' | grep -v '^_'
}

_plsdo_help() {
    local topic="${1-}"
    # print help for the topic
    if [ -n "$topic" ]; then
        if ! command -v "$topic" > /dev/null ; then
            >&2 echo "No such task: $topic"
            return 1
        fi

        printf "\nUsage:\n  %s %s\n\n%s\n" "$0" "$topic" "${help[$topic]-}"
        return 0
    fi

    # print list of tasks and their help line.
    [ -n "${banner-}" ] && echo "$banner" && echo
    for i in $(list); do
        printf "%-${_plsdo_help_task_name_width-15}s\t%s\n" "$i" "${help[$i]-}" | head -1
    done
}
