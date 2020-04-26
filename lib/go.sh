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


# TDOO: Examples
# - cross-compile with parallel
# - ldflags on binary


help[lint]="Run golangci-lint on Go files"
lint() {
    _gotool_install golangci-lint github.com/golangci/golangci-lint/cmd/golangci-lint
    _gotool_run golangci-lint run -v
}

_gotool_run() {
    PATH="./.gotools/bin:$PATH" "$@"
}

_gotool_install() {
    local cmd; cmd="$1"

    if command -v "$cmd" > /dev/null && [[ -z "${FORCE-}" ]]; then
        return
    fi

    local pkg; pkg="$2"
    mkdir -p .gotools
    (
        set -e
        cd .gotools
        GOBIN="$PWD/bin" go get "$pkg"
    )
}

help[test]="Run Go tests"
test() {
    if command -v gotestsum > /dev/null; then
        gotestsum "$@"
        return
    fi
    go test "$@"
}

_version() {
    local sha; sha="$(git rev-parse --short HEAD)"
    echo "1.0.1-$sha"
}
