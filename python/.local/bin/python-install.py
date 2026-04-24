#!/usr/bin/env python

import atexit
import os
import platform
import shutil
import subprocess
import sys
import tarfile
import tempfile
import time
from contextlib import chdir, contextmanager
from pathlib import Path

import requests


def die(message, exit_code=1):
    print(message, file=sys.stderr)
    sys.exit(exit_code)


def prompt_continue():
    answer = input("Continue? [Y/n] ")
    if answer != "Y":
        sys.exit(1)


def cleanup(work_dir, start_time):
    def _cleanup():
        print(f"Deleting {work_dir}...")
        shutil.rmtree(work_dir)
        duration = now() - start_time
        print(f"Runtime: {duration} seconds")
    return _cleanup


def now():
    return int(time.time())


def get_minor_version(python_version):
    return ".".join(python_version.split(".")[:2])


def get_install_dir(python_version):
    return str(
        Path(os.environ["PYENV_ROOT"])
        / "versions"
        / get_minor_version(python_version)
    )


def download_python(python_version):
    python_base = f"Python-{python_version}"
    python_xz = f"{python_base}.tar.xz"
    url = f"https://www.python.org/ftp/python/{python_version}/{python_xz}"
    print(f"Downloading Python {python_version} from {url}...")

    response = requests.get(url)
    with open(python_xz, "wb") as fh:
        fh.write(response.content)

    with tarfile_open(python_xz) as fh:
        fh.extractall()

    return python_base


@contextmanager
def tarfile_open(path, mode="r:xz"):
    fh = tarfile.open(path, mode)
    try:
        yield fh
    finally:
        fh.close()


def python_brew():
    packages = [
        "gdbm",
        "gettext",
        "libffi",
        "libmpdec",
        "openssl",
        "readline",
        "sqlite3",
        "xz",
        "zlib",
    ]

    os.system("brew install pkg-config")
    os.system(f"brew install {" ".join(packages)}")

    cflags = [f"-I{brew_prefix(p)}/include" for p in packages]
    ldflags = [
        f.replace("-I", "-L").replace("/include", "/lib")
        for f in cflags
    ]

    return (
        (os.environ.get("CFLAGS", "") + f" {" ".join(cflags)}").strip(),
        (os.environ.get("LDFLAGS", "") + f" {" ".join(ldflags)}").strip(),
    )


def brew_prefix(package):
    return subprocess.check_output(
        ["brew", "--prefix", package],
        encoding="utf-8",
    ).strip()


def get_os():
    return sys.platform


def get_arch():
    return platform.machine()


def get_system_ffi():
    return "no" if get_os() == "darwin" and get_arch() == "arm64" else "yes"


def main():
    try:
        python_version = sys.argv[1]
    except IndexError:
        die("No Python version specified")

    work_dir = tempfile.mkdtemp()
    atexit.register(cleanup(work_dir, now()))

    install_dir = get_install_dir(python_version)
    print(f"Installing Python {python_version} to {install_dir}...")
    prompt_continue()

    with chdir(work_dir):
        print(f"Downloading Python {python_version} in {os.getcwd()}...")
        work_dir = download_python(python_version)
        with chdir(work_dir):
            cflags, ldflags = python_brew()
            os.environ["CFLAGS"] = cflags
            os.environ["LDFLAGS"] = ldflags
            print("CFLAGS =", os.environ["CFLAGS"])
            print("LDFLAGS =", os.environ["LDFLAGS"])
            prompt_continue()

            system_ffi = get_system_ffi()
            print("system_ffi =", system_ffi)

            openssl_dir = brew_prefix("openssl")
            print("openssl_dir =", openssl_dir)

            prompt_continue()

            configure = " ".join([
                "./configure",
                f"--prefix={install_dir}",
                f"--with-openssl={openssl_dir}",
                f"--with-system-ffi={system_ffi}",
            ])
            os.system(configure)
            prompt_continue()

            os.system("make")
            prompt_continue()

            os.system("make install")
            prompt_continue()

    with chdir(f"{install_dir}/bin"):
        for target in {"pip3", "pydoc3", "python3"}:
            source = Path(target.replace("3", ""))
            source.symlink_to(target)
        os.system("ls -l")


if __name__ == "__main__":
    main()
