#!/usr/bin/env bash

set -ue

mkdir -p ~/.local/bin
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/poem.sh > ~/.local/bin/poem
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/shim.sh > ~/.local/bin/poetry
chmod +x ~/.local/bin/poem ~/.local/bin/poetry

cat << EOF
Installation complete.
Installed at ~/.local/bin, to remove, simply delete ~/.local/bin/poem and ~/.local/bin/poetry

You should add ~/.local/bin to your PATH environment variable, then you can use "poem" and "poetry",
you can do so by copying the line below into your ~/.profile or ~/.zprofile

EOF

echo 'export PATH=${PATH}:'"${HOME}"'/.local/bin'
