import atexit
import os
import os.path
import readline
import rlcompleter
import sys

try:
    startup_py = __file__
    py_config_home = os.path.dirname(py_config_home)
except NameError:
    xdg_config_home = os.environ.get("XDG_CACHE_HOME", "~/.cache")
    xdg_config_home = os.path.expanduser(xdg_config_home)
    py_config_home = os.path.join(xdg_config_home, "python")
    startup_py = os.path.join(py_config_home, "startup.py")

IS_PY3 = sys.version_info[0] == 3
HISTORY_EXT = '.py3' if IS_PY3 else ''
HISTORY_BASE = 'history{}'.format(HISTORY_EXT)
HISTORY = os.path.abspath(os.path.join(py_config_home, HISTORY_BASE))
print("History file is {}.".format(HISTORY))

if IS_PY3:
    sys.ps1 = "\u27a5  "
    sys.ps2 = "\u22ef  "
elif sys.version_info > (2,7,15):
    sys.ps1 = u"\u27a5  ".encode("utf-8")
    sys.ps2 = u"\u22ef  ".encode("utf-8")
else:
    sys.ps1 = "\001\033[030;1m\002>>>\001\033[0m\002 "
    sys.ps2 = "\001\033[030;1m\002...\001\033[0m\002 "

readline.parse_and_bind('tab: complete')

def save_history(path=HISTORY):
    import readline
    readline.write_history_file(path)

if os.path.exists(HISTORY):
    readline.read_history_file(HISTORY)

atexit.register(save_history)

del atexit, HISTORY, HISTORY_BASE, HISTORY_EXT, IS_PY3, os, readline, \
    rlcompleter, save_history, startup_py, sys

try:
    del xdg_config_home
except NameError:
    pass

try:
    from rich import pretty, print, inspect
    pretty.install()
except ImportError:
    pass
