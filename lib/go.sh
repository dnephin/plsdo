#!/usr/bin/env bash
#
# Examples of tasks for Go projects
#

# tell shellcheck about help
declare -A help; export help

help[godoc]="Run godoc locally to read package documentation.

You may want to use this task to preview documentation changes, or read godoc
for private repositories.
"
godoc() {
    local url; url="http://localhost:6060/pkg/$(go list)/"
    command -v xdg-open && xdg-open "$url" &
    command -v open && open "$url" &
    command godoc -http=:6060
}


# Examples
# - cross-compile with parallel
# - ldflags on binary
# - version
# - lint
# - installing binaries to ./.gotools/bin
# - tests


lint() {
    # TODO: install to ./.gotools/bin if missing
    _exec_tool golangci-lint run -v
}


_exec_tool() {
    PATH="./.gotools/bin:$PATH" "$@"
}

_install_tool() {
    local tool; tool="$1"
    (
        set -e
        cd .gotools
        GOBIN="./bin" go get "$tool"
    )
}
