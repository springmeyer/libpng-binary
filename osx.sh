#!/bin/bash
set -e -u
set -o pipefail

export PLATFORM=MacOSX
export PUBLISH=true
export QUIET=false

source ./build.sh
build `git rev-parse --abbrev-ref HEAD`