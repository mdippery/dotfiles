# `py` is a wrapper for executing scripts and programs using custom versions of
# python that are not on the $PATH by default. It is useful on hosts where you
# want to have a custom version of Python that does not interfere with a
# system-installed one.

function py {
  local py_ver
  if [ $1 = '-v' ]; then
    shift
    py_ver=$1
    shift
  else
    py_ver=$(\ls -r1 ~/.pythons | head -n 1)
  fi
  if (( $(echo $py_ver | tr '.' "\n" | wc -l) < 3 )); then
    local py_match=$(find $(readlink -f ~/.pythons) -maxdepth 1 -name "$py_ver".* | head -n 1)
    if [ -z "$py_match" ]; then
      echo "No matching Pythons for ${py_ver}" 2>&1
      return 1
    fi
    py_ver=$(basename $(echo "$py_match"))
  fi
  bin_path="${HOME}/.pythons/${py_ver}/bin"
  env PATH="$bin_path:/usr/bin" $*
}
