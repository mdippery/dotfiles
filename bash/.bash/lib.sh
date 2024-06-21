# lib.sh: Common functions that many bash subscripts may find useful

function onoe {
  echo $* 1>&2
}

function python_major_version {
  python -V 2>&1 | cut -d ' ' -f 2 | cut -d . -f 1
}

source "${DOTBASH}/lib/dots.sh"
source "${DOTBASH}/lib/paths.sh"
source "${DOTBASH}/lib/greet.sh"

# Recreate behavior of GNU `readlink` on OS X
# Some of the bash config scripts expect `readlink -f` to work on OS X
# the same way it does on Linux.
if [ $DOTBASH_OS_NAME = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink=greadlink
  else
    source "${DOTBASH}/lib/readlink.sh"
  fi
fi
