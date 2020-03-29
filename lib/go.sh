# Common Go tasks

help[godoc]="Run godoc locally to read package documentation.

You may want to use godoc to preview godoc changes, or read godoc for private
packages.
"
godoc() {
    local url="http://localhost:6060/pkg/$(go list)/"
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
