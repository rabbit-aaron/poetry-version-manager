#!/usr/bin/env bash

set -ue


BASE_DIR=~/.local/tools/poem/poetry


function _check_version {
  local VERSION=${1}
  curl -s https://pypi.org/pypi/poetry/json | python -c "import sys, json; json.load(sys.stdin)['releases']['${VERSION}']" 2> /dev/null
}


function _ensure_version_exists {
  local VERSION=${1}
  if ! _check_version "${VERSION}"; then
    echo "Poetry version ${VERSION} does not exist" > /dev/stderr
    exit 1
  fi
}


function _ensure_version_installed {
  local VERSION=${1}
  if [ ! -d "${BASE_DIR}/${VERSION}" ]; then
    echo "Poetry version ${VERSION} has not been installed" > /dev/stderr
    exit 1
  fi
}


function install {
  local VERSION="${1}"
  local INSTALL_DIR="${BASE_DIR}/${VERSION}"
  _ensure_version_exists "${VERSION}"
  mkdir -p "${INSTALL_DIR}"
  cd "${INSTALL_DIR}"
  python -m venv .
  ./bin/pip install "poetry==${VERSION}"
}


function remove {
  local VERSION="${1}"
  local INSTALL_DIR="${BASE_DIR}/${VERSION}"
  _ensure_version_installed "${VERSION}"
  rm -rf "${INSTALL_DIR}"
  echo "poetry ${VERSION} has been removed"
}


function set_local {
  local VERSION=${1}
  _ensure_version_exists "${VERSION}"
  echo "${VERSION}" > .poetry-version
}


function set_global {
  local VERSION="${1}"
  _ensure_version_installed "${VERSION}"
  ln -sf "${BASE_DIR}/${VERSION}/bin/poetry" "${BASE_DIR}/global"
  echo "poetry ${VERSION} has been set to global"
}


function show_available {
    curl -s https://pypi.org/pypi/poetry/json | python -c "import sys, json; [print(i) for i in json.load(sys.stdin)['releases']]" 2> /dev/null
}


function show_installed {
    cd "${BASE_DIR}"
    OUTPUT=$(ls -1d */ | sed 's#/##')
    if [ -f "${BASE_DIR}/global" ]; then
      GLOBAL_POETRY=$(readlink "${BASE_DIR}/global")/../..
      GLOBAL_POETRY=$(realpath "${GLOBAL_POETRY}")
      PREFIX="${BASE_DIR}/"
      GLOBAL_VERSION="${GLOBAL_POETRY//${PREFIX}/}"

      OUTPUT="${OUTPUT//${GLOBAL_VERSION}/${GLOBAL_VERSION} <- global}"
    fi
    echo "${OUTPUT}"
}


function usage {
cat << EOF
usage: poem [install|remove|local|global] [version]
poem [show_installed|show_available]
EOF
}


function ensure_one_arg {
  if [ "${1}" -lt 1 ]; then
    usage
    exit
  fi
}


function main {
  local COMMAND="${1}"
  shift
  case "${COMMAND}" in
    install)
      ensure_one_arg "${#}"
      install "${@}"
      ;;
    remove)
      ensure_one_arg "${#}"
      remove "${@}"
      ;;
    local)
      ensure_one_arg "${#}"
      set_local "${@}"
      ;;
    global)
      ensure_one_arg "${#}"
      set_global "${@}"
      ;;
    show_available)
      show_available
      ;;
    show_installed)
      show_installed
      ;;
    *)
      echo "Unknown command ${COMMAND}" > /dev/stderr
      exit 1
      ;;
  esac
}


ensure_one_arg "${#}"
main "${@}"
