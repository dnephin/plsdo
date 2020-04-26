#!/usr/bin/env bash

source plsdo.sh

banner="plsdo - project tasks"

#TODO: test, ci, release

source lib/go.sh
source lib/bash.sh

_plsdo_run "$@"
