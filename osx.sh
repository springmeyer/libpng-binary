#!/bin/bash
set -e -u
set -o pipefail

export PLATFORM=MacOSX
export TARGET=jpeg_turbo
export PUBLISH=true
export QUIET=false

source ./build.sh
build $TARGET