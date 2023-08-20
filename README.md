```
usage: poem [install|remove|local|global] [version]
poem [show_installed|show_available]
```

# Why is this needed?
I work in a company across multiple projects, most of the time they don't have exactly the same poetry version.
This becomes a problem when I run `poetry update` or `poetry lock` as different versions of poetry might
generate different `poetry.lock` file.

I took inspiration from `pyenv` and created this project.



# Installation

__IMPORTANT: uninstall poetry first.__

```shell
curl https://raw.githubusercontent.com/rabbit-aaron/poetry-version-manager/main/get_poem.sh | bash
```
_After running the script above, you need to follow the instructions in the stdout to setup poem and the shim in your PATH_
# Usage
To see all the available `poetry` versions on `PyPI`:
```shell
poem show_available
```

To see all `poetry` versions installed by `poem`:
```shell
poem show_installed
```

To install a specific version of `poetry`:
```shell
poem install <version_number>
```

To remove a specific version of `poetry`:
```shell
poem remove <version_number>
```

Set current project's `poetry` version:
```shell
# run in the same folder as pyproject.toml
poem local <version_number>
# a `.poetry-version` file will be created with the <version_number> as its content
# note that unlike pyenv, poem only check `.poetry-version` in the same folder as `pyproject.toml`
# it does not check parent directories.
```

Set global `poetry` version:
```shell
poem global <version_number>
```
