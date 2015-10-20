function readlink {
  if [ $1 != '-f' ]; then
    /usr/bin/readlink $*
  else
    shift
    local target_file=$1
    python -c 'import os,sys; print os.path.realpath(sys.argv[1])' "$target_file"
  fi
}
