#!/bin/bash

UNAME=$(uname -s)

function setup {
  set -e -u
  set -o pipefail
  export ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}

function teardown {
  set +e  
}

function q {
  if [[ "${QUIET:-false}" != false ]]; then
    $1 1>> build.log
  else
    $1
  fi
}

function prepare {
  if [[ $UNAME == 'Linux' ]]; then
    sudo apt-get update -y -qq
    sudo apt-get install -qq -y build-essential zlib1g-dev
    sudo apt-get purge -qq -y libpng*
    sudo apt-get autoremove -y -qq
  fi
  if [ ! -d mapnik-packaging ]; then
    git clone --depth 1 https://github.com/mapnik/mapnik-packaging.git
  fi
  cd mapnik-packaging/osx
  source ${PLATFORM}.sh
  echo "Running build with ${JOBS} parallel jobs"
}

function publish {
  name=$1
  if [[ "${PUBLISH:-false}" != false ]]; then
      cd $BUILD/../
      # todo version
      TARBALL_DIR=${name}-${platform}-${CXX_STANDARD}-${STDLIB}-${CXX_NAME}
      TARBALL_NAME="${TARBALL_DIR}.tar.bz2"
      UPLOAD="s3://mapnik/dist/dev/${TARBALL_NAME}"
      mv ${BUILDDIR}-$ARCH_NAME ${TARBALL_DIR}
      time tar -c -j -f ${TARBALL_NAME} ${TARBALL_DIR}/
      tar -tvf ${TARBALL_NAME}
      ensure_s3cmd
      echo "*uploading ${UPLOAD}"
      s3cmd --acl-public put ${TARBALL_NAME} ${UPLOAD}
  else
      echo 'skipping publishing'
  fi
}

function build {
  if [ -z "$1" ]; then
    echo 'please pass argument of what to build'
    exit 1
  fi
  name=$1
  setup
  prepare
  ./scripts/build_$name.sh $2
  publish $1 $2
  teardown
}

export -f build
