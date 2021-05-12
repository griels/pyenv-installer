#!/bin/bash
#
# Usage: curl https://pyenv.run | bash
#
# For more info, visit: https://raw.githubusercontent.com/pyenv/pyenv-installer
#
if [ -n "$PYENV_REPO" ]; then
  PYENV_REPO="pyenv/pyenv-installer"
fi
index_main() {
    set -e
    curl -s -S -L https://raw.githubusercontent.com/${PYENV_REPO}/master/bin/pyenv-installer | bash
}

index_main