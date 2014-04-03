#!/bin/bash
set -e -u
set -o pipefail

export PLATFORM=MacOSX
export TARGET=png
export PUBLISH=true
export QUIET=false

source ./build.sh
build $TARGET