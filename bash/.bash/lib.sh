# lib.sh: Common functions that many bash subscripts may find useful

function onoe {
  echo $* 1>&2
}
export -f onoe

source "${DOTBASH}/lib/paths.sh"
source "${DOTBASH}/lib/greet.sh"
