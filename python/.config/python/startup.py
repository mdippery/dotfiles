import os.path
import sys

sys.ps1 = "\001\033[030;1m\002>>>\001\033[0m\002 "
sys.ps2 = "\001\033[030;1m\002...\001\033[0m\002 "

if os.path.exists("/etc/pythonstart"):
    with open("/etc/pythonstart", "r") as fh:
        exec(fh.read())

del fh, sys
