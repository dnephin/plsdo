#!/usr/bin/env bash
#
# Examples of tasks for projects with bash scripts
#

# tell shellcheck about help
declare -A help; export help

# shellcheck disable=SC2016
help[test_commands]="Test that all commands used by this script are in \$PATH"
test_commands() {
    cmds=( awk grep head )
    for c in "${cmds[@]}"; do
        if ! command -v "$c"; then _plsdo_error "Missing $c in \$PATH"; fi
    done
}

help[shellcheck]="Run shellcheck on all files."
shellcheck() {
    if ! command -v shellcheck > /dev/null; then
        _plsdo_error "shellcheck: command not found"
        _plsdo_error "Try https://github.com/koalaman/shellcheck#installing"
        return 3
    fi
    command shellcheck -S style ./do ./plsdo.sh lib/*.sh
}
