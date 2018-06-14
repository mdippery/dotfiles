# lib.sh: Common functions that many bash subscripts may find useful

function dotbash {
  case $1 in
    host) echo "${DOTBASH}/host/${DOTBASH_HOSTNAME_HASH}" ;;
    plat) echo "${DOTBASH}/plat/${DOTBASH_OS}"            ;;
    sys)  echo "${DOTBASH}/sys/${DOTBASH_SYS}"            ;;
    *)    echo $DOTBASH                                   ;;
  esac
}

function manpaths-helper {
  export MANPATHS_FILE="$(dotbash sys)/manpaths"
  if [ -r "$MANPATHS_FILE" ]; then
    tr '\n' ':' < "$MANPATHS_FILE" | sed 's/:$//'
  else
    echo $MANPATH
  fi
}

function paths-helper {
  export PATHS_FILE="$(dotbash sys)/paths"
  if [ -r "$PATHS_FILE" ]; then
    tr '\n' ':' < "$PATHS_FILE" | sed 's/:$//'
  else
    echo $PATH
  fi
}

function onoe {
  echo $* 1>&2
}

source "$(dotbash)/lib/dots.sh"

# Recreate behavior of GNU `readlink` on OS X
# Some of the bash config scripts expect `readlink -f` to work on OS X
# the same way it does on Linux.
if [ $DOTBASH_OS = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink='greadlink'
  else
    source "$(dotbash)/lib/readlink.sh"
  fi
fi
