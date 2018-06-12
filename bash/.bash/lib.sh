# lib.sh: Common functions that many bash subscripts may find useful

function manpaths-helper {
  export MANPATHS_FILE="${DOTBASH}/host/${HOSTNAME_HASH}/manpaths"
  if [ -r "$MANPATHS_FILE" ]; then
    tr '\n' ':' < "$MANPATHS_FILE" | sed 's/:$//'
  else
    echo $MANPATH
  fi
}

function paths-helper {
  export PATHS_FILE="${DOTBASH}/host/${HOSTNAME_HASH}/paths"
  if [ -r "$PATHS_FILE" ]; then
    tr '\n' ':' < "$PATHS_FILE" | sed 's/:$//'
  else
    echo $PATH
  fi
}

function onoe {
  echo $* 1>&2
}

source "${DOTBASH}/lib/dots.sh"

# Recreate behavior of GNU `readlink` on OS X
# Some of the bash config scripts expect `readlink -f` to work on OS X
# the same way it does on Linux.
if [ $OS = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink='greadlink'
  else
    source "${DOTBASH}/lib/readlink.sh"
  fi
fi
