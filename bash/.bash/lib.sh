# lib.sh: Common functions that many bash subscripts may find useful

hash brew 2>/dev/null || source "${DOTBASH}/lib/brew.sh"

source "${DOTBASH}/lib/python.sh"

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
