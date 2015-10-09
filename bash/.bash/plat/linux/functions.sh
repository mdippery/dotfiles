# Recreate OS X's `otool -L` on Linux
function otool {
  if (( $# < 1 )) || [[ $1 != '-L' ]]; then
    local cmd='ldd'
    if (( $# > 0 )); then
      cmd="$cmd $*"
    fi
    echo "I think you mean \`$cmd\`" 2>&1
    return 1
  fi
  shift
  ldd "$1"
}