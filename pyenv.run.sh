#!/bin/bash
#
# Usage: curl https://pyenv.run | bash
#
# For more info, visit: https://raw.githubusercontent.com/pyenv/pyenv-installer
#

PYENV_REPO="griels"

index_main() {
    set -e
    curl -s -S -L https://raw.githubusercontent.com/${PYENV_REPO}/master/bin/pyenv-installer | bash
}

if [ -z "$PYENV_INSTALLING" ]; then
  index_main
fi