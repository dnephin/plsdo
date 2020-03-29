#!/usr/bin/env bash
# Common Go tasks

# shellcheck disable=SC2034
help["godoc"]="Run godoc locally to read package documentation.

You may want to use godoc to preview godoc changes, or read godoc for private
packages.
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
