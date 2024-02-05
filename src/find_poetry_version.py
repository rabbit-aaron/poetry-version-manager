import pathlib

def main():
    cwd = pathlib.Path(".").resolve()
    root = pathlib.Path("/")
    while True:
        poetry_version = cwd / ".poetry-version"
        if poetry_version.is_file():
            print(poetry_version.read_text().strip())
            return 0

        if cwd == root:
            return 0

        cwd = cwd.parent



if __name__ == "__main__":
    raise SystemExit(main())
