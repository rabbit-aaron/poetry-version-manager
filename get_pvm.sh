#!/usr/bin/env bash

set -ue
git clone https://github.com/rabbit-aaron/poetry-version-manager /tmp/pvm
mkdir -p ~/.local/bin

cp /tmp/pvm/src/pvm.sh ~/.local/bin/pvm
cp /tmp/pvm/src/shim.sh ~/.local/bin/poetry

rm -rf /tmp/pvm

cat << EOF
Installation complete.
Installed at ~/.local/bin, to remove, simply delete ~/.local/bin/pvm and ~/.local/bin/poetry

You should add ~/.local/bin to your '${PATH}', then you can use "pvm" and "poetry"
EOF
