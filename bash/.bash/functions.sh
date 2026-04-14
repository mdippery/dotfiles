function aws-profile {
  if [ $1 == '--clear' ]; then
    unset AWS_PROFILE
  else
    export AWS_PROFILE=$1
  fi
}

function bash-functions {
  declare -F | awk '{print $3}'
}

# Reads a .env file into variables
function dotenv {
  set -a
  source ${1:-.env}
  set +a
}

# A nicer man with colorized text
# Inspired by <http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized>
function man {
  env \
    LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_se=$(tput sgr0) \
    LESS_TERMCAP_so=$(tput bold; tput setab 0; tput setaf 2) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_us=$(tput bold; tput setaf 5) \
    man "$@"
}

# Creates a new folder and cd's into it
function mkcd {
  mkdir -pv "${1:?}" && cd "$1"
}

# Pretty-print the current env
function ppenv {
  command env | sort | column -s = -t
}

# Show quick bash nav help
function qh {
  cat <<EOS | column -t -s,
ctrl-a,Move to beginning of line
ctrl-e,Move to end of line
meta-b,Move back one word
meta-f,Move forward one word
ctrl-x ctrl-e,Open command line in $EDITOR
ctrl-u,Delete from cursor to beginning of line
ctrl-k,Delete from cursor to end of line
ctrl-w,Delete word before cursor
meta-d,Delete word after cursor
ctrl-d,Delete current character
ctrl-t,Transpose current character with previous
meta-t,Transpose current word with previous
meta-l,Make lowercase word after cursor
meta-u,Make uppercase word after cursor
ctrl-s/ctrl-q,Stop/restart terminal output
EOS
}

# rg with automatic paging, the way God intended
function rg {
  command rg "$@" | $PAGER
}

function sbt_classes {
  if [ ! -d target ]; then return 1; fi
  echo "$(find target -name scala-* -type d 2>/dev/null | sort -V | tail -n 1)/classes"
}

function tfcd {
  local cmd
  if [[ $1 == -p ]]; then
    cmd=pushd
  else
    cmd=cd
  fi
  shift
  $cmd $(git rev-parse --show-toplevel)
}

function which {
  local which_prefix
  if [ -x ${BREW_PREFIX}/bin/which ]; then
    which_prefix=${BREW_PREFIX}/bin
  else
    which_prefix=${BREW_PREFIX}/opt/gnu-which/libexec/gnubin
  fi
  (alias ; declare -f) | $which_prefix/which --tty-only --read-alias --read-functions --show-dot --show-tilde $*
}
export -f which

function whichsh {
  # Inspired by <https://nil.wallyjones.com/what-shell-am-i-using/>
  lsof -p $$ | tail -n +3 | head -n 1 | awk '{print $NF}'
}

function whois { command whois $1 | $PAGER; }

[ -r "${DOTBASH_OS}/functions.sh" ] && source "${DOTBASH_OS}/functions.sh"
[ -r "${DOTBASH}/functions.user.sh" ] && source "${DOTBASH}/functions.user.sh"

# vim: set ft=bash :
