#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

_plsdo_error() {
    >&2 echo "$@"
}

# shellcheck disable=SC2016
help[_plsdo_completion]='Print tab completion for $SHELL.

Redirect the output to a file that will be run when the shell starts,
such as ~/.bashrc.

    $ ./do _pldsdo_completion >> ~/.bash_complete/do
'
_plsdo_completion() {
    local shell; shell="$(basename "$SHELL" 2> /dev/null)"
    case "$shell" in
    bash)
        cat <<+++
_dotslashdo_completions() {
    if ! command -v $0 > /dev/null; then return; fi
    if [ "\${#COMP_WORDS[@]}" != "2" ]; then return; fi
    COMPREPLY=(\$(compgen -W "\$($0 list)" "\${COMP_WORDS[1]}"))
}
complete -F _dotslashdo_completions $0
+++
        ;;
    "")
        _plsdo_error "Set \$SHELL to select tab completion."
        return 1 ;;
    *)
        _plsdo_error "No completetion for shell: $shell"
        return 1 ;;
    esac
}
