#!/usr/bin/env bash

set -ue

mkdir -p ~/.local/bin
mkdir -p ~/.local/tools/poem
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/poem.sh > ~/.local/tools/poem/poem.sh
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/shim.sh > ~/.local/tools/poem/shim.sh
curl -s https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/src/find_poetry_version.py > ~/.local/tools/poem/find_poetry_version.py
chmod +x ~/.local/tools/poem/shim.sh ~/.local/tools/poem/poem.sh

rm -f ~/.local/bin/poetry ~/.local/bin/poem
ln -s ~/.local/tools/poem/shim.sh ~/.local/bin/poetry
ln -s ~/.local/tools/poem/poem.sh ~/.local/bin/poem

cat << EOF
Installation complete.
Installed at ~/.local/bin, to remove, simply delete ~/.local/bin/poem, ~/.local/bin/poetry ~/.local/tools/poem

You should add ~/.local/bin to your PATH environment variable, then you can use "poem" and "poetry",
you can do so by copying the line below into your ~/.profile or ~/.zprofile

EOF

echo 'export PATH=${PATH}:'"${HOME}"'/.local/bin'
