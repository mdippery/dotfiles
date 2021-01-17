# lib.sh: Common functions that many bash subscripts may find useful

function dotbash {
  case $1 in
    host) echo "${DOTBASH}/host/${DOTBASH_HOSTNAME_HASH}" ;;
    plat) echo "${DOTBASH}/plat/${DOTBASH_OS}"            ;;
    sys)  echo "${DOTBASH}/sys/${DOTBASH_SYS}"            ;;
    *)    echo $DOTBASH                                   ;;
  esac
}

function onoe {
  echo $* 1>&2
}

function python_major_version {
  python -V 2>&1 | cut -d ' ' -f 2 | cut -d . -f 1
}

source "$(dotbash)/lib/dots.sh"
source "$(dotbash)/lib/paths.sh"
source "$(dotbash)/lib/greet.sh"

# Recreate behavior of GNU `readlink` on OS X
# Some of the bash config scripts expect `readlink -f` to work on OS X
# the same way it does on Linux.
if [ $DOTBASH_OS = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink=greadlink
  else
    source "$(dotbash)/lib/readlink.sh"
  fi
fi
