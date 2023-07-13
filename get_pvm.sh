#!/usr/bin/env bash

set -ue

mkdir -p ~/.local/bin
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/pvm.sh > ~/.local/bin/pvm
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/shim.sh > ~/.local/bin/poetry
chmod +x ~/.local/bin/pvm ~/.local/bin/poetry

cat << EOF
Installation complete.
Installed at ~/.local/bin, to remove, simply delete ~/.local/bin/pvm and ~/.local/bin/poetry

You should add ~/.local/bin to your PATH environment variable, then you can use "pvm" and "poetry",
you can do so by copying the line below into your ~/.profile or ~/.zprofile

EOF

echo 'export PATH=${PATH}:'"${HOME}"'/.local/bin'
