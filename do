#!/usr/bin/env bash

source plsdo.sh

banner="plsdo - project tasks"

exit_missing_binary=3

help[check]="Run shellcheck on all files."
check() {
    if ! command -v shellcheck > /dev/null; then
        _plsdo_error "Missing shellcheck."
        _plsdo_error "See https://github.com/koalaman/shellcheck#installing"
        return "$exit_missing_binary"
    fi
    shellcheck -S style -e SC2016 ./do ./plsdo.sh lib/*.sh
}

#TODO: test, ci, release

source lib/go.sh

_plsdo "$@"
