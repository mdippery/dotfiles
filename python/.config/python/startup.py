import atexit
import os.path
import readline
import rlcompleter
import sys

HISTORY = os.path.abspath(os.path.join(os.path.dirname(__file__), 'history'))

sys.ps1 = "\001\033[030;1m\002>>>\001\033[0m\002 "
sys.ps2 = "\001\033[030;1m\002...\001\033[0m\002 "

readline.parse_and_bind('tab: complete')

def save_history(path=HISTORY):
    import readline
    readline.write_history_file(path)

if os.path.exists(HISTORY):
    readline.read_history_file(HISTORY)

atexit.register(save_history)

del atexit, HISTORY, os, readline, rlcompleter, save_history, sys
