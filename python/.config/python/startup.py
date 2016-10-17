import os.path
import sys

sys.ps1 = "\033[030;1m>>>\033[0m "
sys.ps2 = "\033[030;1m...\033[0m "

if os.path.exists("/etc/pythonstart"):
    with open("/etc/pythonstart", "r") as fh:
        exec(fh.read())

del fh, sys
