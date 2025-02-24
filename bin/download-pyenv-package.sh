#!/usr/bin/env bash

export PYENV_INSTALLING="True"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

checkout() {
  [ -d "$2" ] && (cd "$2"; git clone "$1")
}

if [ -z "$PYENV_PACKAGE_ARCHIVE" ]; then
  PYENV_PACKAGE_ARCHIVE="$(cd $(dirname "$0") && pwd)/pyenv-package.tar.gz"
fi

if [ -z "$PYENV_DL_TARGET" ]; then
  TMP_DIR=$(mktemp -d)
else
  TMP_DIR=$PYENV_DL_TARGET
fi
if [ -n "${USE_HTTPS}" ]; then
  GITHUB="https://github.com"
else
  GITHUB="git://github.com"
fi

if [ -z "${PYENV_VERSION}" ]; then
  PYENV_VERSION=HEAD
fi

if [ -z "${INSTALLER_REPO}" ]; then
  INSTALLER_REPO=$(bash -c "cd ${SCRIPT_DIR} && git remote get-url origin")
fi
if [ -z "${INSTALLER_REPO}" ]; then
  source "${SCRIPT_DIR}/../pyenv.run.sh"
  INSTALLER_REPO="${GITHUB}/${PYENV_REPO}/pyenv-installer.git"
fi
# checkout to temporary directory.
checkout "${GITHUB}/pyenv/pyenv.git@${PYENV_VERSION}"            "$TMP_DIR"
checkout "${GITHUB}/pyenv/pyenv-doctor.git"     "$TMP_DIR"
checkout "${INSTALLER_REPO}"     "$TMP_DIR"
checkout "${GITHUB}/pyenv/pyenv-update.git"     "$TMP_DIR"
checkout "${GITHUB}/pyenv/pyenv-virtualenv.git" "$TMP_DIR"
checkout "${GITHUB}/pyenv/pyenv-which-ext.git"  "$TMP_DIR"

if [ -z "${PYENV_DL_TARGET}" ]; then
  # create archive.
  tar -zcf "$PYENV_PACKAGE_ARCHIVE" -C "$TMP_DIR" .
  echo "Created installer archive at $PYENV_PACKAGE_ARCHIVE"
  rm -rf $TMP_DIR
fi
