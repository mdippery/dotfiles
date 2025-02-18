import atexit
import os
import os.path
import readline
import rlcompleter
import sys

xdg_state_home = os.environ.get("XDG_STATE_HOME", "~/.local/state")
xdg_state_home = os.path.expanduser(xdg_state_home)
py_state_home = os.path.join(xdg_state_home, "python")
startup_py = os.path.join(py_state_home, "startup.py")

try:
    os.mkdir(py_state_home, mode=0o700)
except FileExistsError:
    pass
else:
    print("Created {}.".format(py_state_home))

IS_PY3 = sys.version_info[0] == 3
IS_PY_LT_313 = sys.version_info[:2] < (3, 13)

if IS_PY3:
    sys.ps1 = "\u27a5  "
    sys.ps2 = "\u22ef  "
elif sys.version_info > (2,7,15):
    sys.ps1 = u"\u27a5  ".encode("utf-8")
    sys.ps2 = u"\u22ef  ".encode("utf-8")
else:
    sys.ps1 = "\001\033[030;1m\002>>>\001\033[0m\002 "
    sys.ps2 = "\001\033[030;1m\002...\001\033[0m\002 "

# Python 3.13 respects $PYTHON_HISTORY for setting history location
if IS_PY_LT_313:
    HISTORY_EXT = '.py3' if IS_PY3 else ''
    HISTORY_BASE = 'history{}'.format(HISTORY_EXT)
    HISTORY = os.path.abspath(os.path.join(py_state_home, HISTORY_BASE))
    print("History file is {}.".format(HISTORY))

    readline.parse_and_bind('tab: complete')

    def save_history(path=HISTORY):
        import readline
        readline.write_history_file(path)

    if os.path.exists(HISTORY):
        readline.read_history_file(HISTORY)

    atexit.register(save_history)

    del HISTORY, HISTORY_BASE, HISTORY_EXT, save_history
elif "PYTHON_HISTORY" not in os.environ:
    print("$PYTHON_HISTORY is unset.")
    print(f"Please set $PYTHON_HISTORY to customize Python history file location.")

# Python 3.13 includes an interactive terminal with color
if IS_PY_LT_313:
    try:
        from rich import pretty, print, inspect
        pretty.install()
    except ImportError:
        pass

del atexit, IS_PY_LT_313, IS_PY3, os, readline, rlcompleter, startup_py, sys

try:
    del xdg_state_home, py_state_home
except NameError:
    pass
