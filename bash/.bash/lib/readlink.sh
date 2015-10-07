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
