#!/usr/bin/env bash

set -ue


BASE_DIR=~/.local/tools/poem/poetry
FINDER_SCRIPT=~/.local/tools/poem/find_poetry_version.py

function _ensure_version_installed {
  local VERSION=${1}
  if [ ! -d "${BASE_DIR}/${VERSION}" ]; then
    echo "Poetry version ${VERSION} has not been installed" > /dev/stderr
    exit 1
  fi
}


function _find_executable {
  local VERSION
  local REAL_LINK
  local LINK_DIR
  VERSION=$(python "${FINDER_SCRIPT}")
  if [ ! -z "${VERSION}" ]; then
    _ensure_version_installed "${VERSION}"
#    export VIRTUAL_ENV=${BASE_DIR}/${VERSION}
    POETRY="${BASE_DIR}/${VERSION}/bin/poetry"
  else
    POETRY="${BASE_DIR}/global"
    REAL_LINK=$(readlink "${POETRY}")
    LINK_DIR=$(dirname "${REAL_LINK}")
#    export VIRTUAL_ENV=${LINK_DIR}
    if [ ! -f "${POETRY}" ]; then
      echo "Global poetry version has not been set" > /dev/stderr
      exit 1
    fi
  fi
}

_find_executable
set +u
"${POETRY}" "${@}"
