# lib.sh: Common functions that many bash subscripts may find useful

# Parts of the bash config scripts rely on `brew`, which is only installed
# on my Macs. Instead of wrapping a lot of the logic in conditionals
# that check for the presence of `brew`, provide a fake one if it is
# not installed.
if ! hash brew 2>/dev/null; then
  function brew {
    echo "${OPT:-/usr/local}"
  }
fi

# Recreate behavior of GNU `readlink` on OS X
# Some of the bash config scripts expect `readlink -f` to work on OS X
# the same way it does on Linux.
if [ $OS = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink='greadlink'
  else
    function readlink {
      if [ $1 != '-f' ]; then
        /usr/bin/readlink $*
      else
        shift
        local target_file=$1
        cd $(dirname "$target_file")
        target_file=$(basename $target_file)
        while [ -L "$target_file" ]; do
          target_file=$(readlink "$target_file")
          cd $(dirname "$target_file")
          target_file=$(basename "$target_file")
        done
        local phys_dir=$(pwd -P)
        local res="${phys_dir}/${target_file}"
        echo $res
      fi
    }
  fi
fi
