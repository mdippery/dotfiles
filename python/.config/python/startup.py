import atexit
import os.path
import readline
import rlcompleter
import sys

try:
    startup_py = os.path.dirname(__file__)
except NameError:
    xdg_config_home = os.environ.get("XDG_CONFIG_HOME", "~/.config/python")
    xdg_config_home = os.path.expanduser(xdg_config_home)
    startup_py = os.path.join(xdg_config_home, "startup.py")

IS_PY3 = sys.version_info[0] == 3
HISTORY_EXT = '.py3' if IS_PY3 else ''
HISTORY_BASE = 'history{}'.format(HISTORY_EXT)
HISTORY = os.path.abspath(os.path.join(os.path.dirname(startup_py), HISTORY_BASE))

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
