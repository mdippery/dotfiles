import operator
import os.path
import sys

def compare_versions(op, given, current):
    ops = {
        '>': operator.gt,
        '<': operator.lt,
        '>=': operator.ge,
        '<=': operator.le,
        '!=': operator.ne,
        '==': operator.eq,
    }
    return ops[op](current, given)

ARGV = sys.argv[1:] if os.path.basename(sys.argv[0]) == os.path.basename(__file__) else sys.argv
VERSION = sys.version_info[0:3]

if len(ARGV) == 0:
    print ".".join(map(str, VERSION))
    sys.exit(0)

if len(ARGV) == 1:
    print >>sys.stderr, "Usage: python_version.py OP VERSION"
    sys.exit(128)

op = ARGV[0]
cmp_ver = tuple(map(int, ARGV[1].split('.')))

if len(cmp_ver) < 3:
    VERSION = sys.version_info[0:len(cmp_ver)]

res = compare_versions(op, cmp_ver, VERSION)
sys.exit({True: 0, False: 1}[res])
