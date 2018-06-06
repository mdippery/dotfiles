# lib.sh: Common functions that many bash subscripts may find useful

function manpaths_helper {
  cat ${HOME}/.manpaths.d/* | tr '\n' ':' | sed 's/:$//'
}

function paths_helper {
  cat ${HOME}/.paths.d/* | tr '\n' ':' | sed 's/:$//'
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
