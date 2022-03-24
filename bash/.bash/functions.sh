function airport-code {
  curl -s "https://airlabs.co/api/v6/airports?api_key=356cad88-f3a3-4a7e-aeec-fad56d838158&code=$1" \
    | jq .response[0].name \
    | tr -d '"'
}

function aws-secret {
  aws secretsmanager get-secret-value --secret-id $1 --version-stage AWSCURRENT \
    | jq '.SecretString' \
    | python -c 'import json, sys; print(json.load(sys.stdin));' \
    | jq
}

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

function bcat {
  if hash $1 2>/dev/null; then
    less $(which $1)
  else
    which $1
  fi
}

function binroot {
  if (( $# < 1 )); then
    onoe 'binroot <path>'
    return 1
  fi
  dirname $(dirname $(which $1))
}

function cabal-platform {
  local arch=$(uname -m)
  local os="$OS"
  if [ "$OS" = 'darwin' ]; then
    os='osx'
  fi
  if hash ghc 2>/dev/null; then
    local ghc=$(ghc --version | awk '{print $(NF)}')
    echo "${arch}-${os}-ghc-${ghc}"
  else
    onoe 'GHC is not installed'
    return 1
  fi
}

function cat-all {
  local dir seen
  dir=$1
  seen='no'
  for fn in $(find $dir -type f); do
    [[ $seen == 'yes' ]] && echo
    tput setaf 1
    echo $fn
    tput sgr0
    cat "$fn"
    seen='yes'
  done
}

function char { echo -n "$1" | hexdump -C; }

function colors {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

# Via <https://github.com/cookiecutter/cookiecutter/issues/784#issuecomment-283529086>
function cookiecutter-apply {
  local repo_url
  repo_url=$1
  cookiecutter --output-dir=.. --config-file=.cookiecutter.yaml --no-input --overwrite-if-exists $repo_url
}

function covid19 {
  local code=${1:-us}
  if [ $code = '--help' -o $code == '-h' ]; then
    curl https://covid19tracker.xyz/help
    return
  fi
  curl https://covid19tracker.xyz/$code
}

function docker-prune {
  docker container prune -f
  docker image prune -f
  docker image ls
}

# Calculate the age of a dog in "dog years", based on the formula in
# <https://mpd.im/2WeW6qZ>
function dog-years {
  python <<EOS
import math
y = int("$1")
age = round(math.log(y) * 16 + 31)
print("{:d}".format(age))
EOS
}

# Reads a .env file into variables
function dotenv {
  set -a
  source ${1:-.env}
  set +a
}

function find-ext {
  local path ext
  if (( $# == 2 )); then
    path=$1
    ext=$2
  else
    path=.
    ext=$1
  fi
  find "$path" -name '*.'$ext
}

# Downloads and extracts the given tar archive
function get {
  local f expand
  f=$1
  case $f in
    *.tbz | *.bz2) expand='bunzip2' ;;
    *.tar)         expand='cat'     ;;
    *.tgz | *.gz)  expand='gunzip'  ;;
    *.xz)          expand='unxz'    ;;

    *)
      onoe "Unrecognized archive type: $(basename $f)"
      return 1
      ;;
  esac
  curl $f | $expand | tar xf -
}

function get-pip { wget https://bootstrap.pypa.io/get-pip.py; }

function grab-line { sed -n "$1 p"; }

function haskell-docs {
  mkdir -p docs
  ln -snfv $(realpath --relative-to=docs $(stack path --local-doc-root)) docs/api
  ln -snfv $(realpath --relative-to=docs $(stack path --local-hpc-root)) docs/coverage
}

# Returns IP data for a given host
function hostinfo {
  for ip in $(hostip $1); do
    ipinfo $ip
  done
}

# Returns the IP address for a given host
function hostip { host $1 | command grep 'has address' | awk '{ print $4 }'; }

# Retrieves information for the given HTTP status code
function httpstatus { lynx "https://httpstatuses.com/$1"; }

# Returns the HTTP status code for a URL
function hstat { curl -I $1 2>/dev/null | head -1; }

# Returns IP information
function ipinfo {
  curl -s ipinfo.io/$1
  echo
}

# List local ivy packages
function ivy-local {
  find ~/.ivy2/local -mindepth 2 -maxdepth 2 -type d -exec basename {} \; | sort
}

# Show known SSH hosts
function known-hosts {
  cut -d ' ' -f 1 < ~/.ssh/known_hosts | cut -d ',' -f 1 | sort
}

# Generate compleat config file for `lein`
function lein-compleat {
  local lein_help=$(lein help)
  local lein_help_start=$(sed -n '/Several tasks/=' <<< "$lein_help")
  local lein_help_end=$(sed -n '/Run `lein help $TASK` for details/=' <<< "$lein_help")
  local x=$((lein_help_start + 1))
  local y=$((lein_help_end - 2))
  echo "$lein_help" \
    | sed -n "${x},${y}p" \
    | awk '{print "lein " $1 ";"}'
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

# Runs the manylinux Docker container for building Python packages
# From <https://github.com/pypa/auditwheel>
# See <https://quay.io/organization/pypa> for possible images.
function manylinux {
  local image
  # image=${MANYLINUX_IMAGE:-manylinux_2_24_x86_64}
  image=${MANYLINUX_IMAGE:-manylinux2014_x86_64}
  docker run --rm -it -v $(pwd):/io quay.io/pypa/$image /bin/bash
}

# Creates a new folder and cd's into it
function mkcd {
  mkdir -pv "${1:?}" && cd "$1"
}

# Mimics nc -z on systems with ncat
function nz {
  (echo | nc -w1 $1 $2 >/dev/null 2>&1) && echo 'OPEN' || echo 'CLOSED'
}

# Upgrades outdated pip dependencies
function pip-outdated {
  pip list -o | cut -d ' ' -f 1 | xargs pip install -U
}

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

# Pretty-print the current env
function ppenv {
  command env | sort | column -s = -t
}

# Removes .pyc files
function pyclean {
  local dir=.
  if (( $# > 0 )); then
    dir=$1
  fi
  find "$dir" -name '*.pyc' -delete
  find "$dir" -name __pycache__ -delete
}

function pyenv-all {
  command ls -1 ~/.pyenv/versions/ | sort -rV | paste -sd : -
}

function pyman {
  python -c "import $1; help($1)"
}

# Prints the python path
function pypath {
  python -c 'import os.path, sys; print("\n".join(map(os.path.abspath, sys.path)))' \
    | sed 's/^$/\./g'
}

# Prints the python prefix
function pyprefix {
  python -c 'import sys; print(sys.prefix)'
}

function python-flags {
  local pkgs
  pkgs='libffi openssl sqlite3 xz zlib'
  CFLAGS=-I$(brew --prefix)/include
  for pkg in $pkgs; do
    CFLAGS="${CFLAGS} -I$(brew --prefix $pkg)/include"
  done
  CFLAGS=$(echo $CFLAGS | sed -e 's/ $//')
  LDFLAGS=$(echo $CFLAGS | tr 'I' 'L' | ruby -e 'puts STDIN.read.chomp.gsub(/\/include/, "/lib")')

  export CFLAGS
  export LDFLAGS

  local system_ffi=yes
  if [ $(arch) = arm64 ]; then system_ffi=no; fi

  env | egrep '(C|LD)FLAGS'
  echo ./configure \
    --prefix=$PYENV_ROOT/versions/\$version \
    --with-openssl=$(brew --prefix openssl) \
    --with-system-ffi=$system_ffi \
    --with-system-libmpdec
}

# List all direct dependencies for a package
function python-requires {
  python setup.py egg_info >/dev/null 2>&1
  cat *.egg-info/requires.txt
}

function pyvenv {
  local cmd
  if [ $(python_major_version) == 3 ]; then
    cmd="python -m venv $*"
  else
    cmd="virtualenv $*"
  fi
  echo $cmd
  eval $cmd
}

# Lists all repositories on my private Git server
function remote-repos {
  ssh git@git.mipadi.com "find . -name '*.git' -type d | cut -c 3- | sort"
}

# Repeats a character a given number of times
function repeat {
  local ch=$1
  local n=$2
  printf %${n}s | tr ' ' $ch
}

# Does a reverse DNS lookup on an IP
function rvdns { nslookup $1 | awk '/name = .*\.$/ {print $4}' | sed 's/\.$//'; }

function sbt_classes {
  if [ ! -d target ]; then return 1; fi
  echo "$(find target -name scala-* -type d 2>/dev/null | sort -V | tail -n 1)/classes"
}

function scpv {
  local host path
  host=$(echo "$1" | cut -d : -f 1)
  path=$(echo "$1" | cut -d : -f 2)
  ssh $host "cat $path" | pv -bpt > $(basename path)
}

function showcert {
  echo \
    | openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null \
    | openssl x509 -inform pem -noout -text
}

function term-title {
  if [[ $1 == --reset ]]; then
    echo -ne "\033]0;\007"
  else
    echo -ne "\033]0;$1\007"
  fi
}

function trim { cut -c-$(tput cols); }

function unixtime {
  python -c "import time; print(time.asctime(time.localtime($1)))"
}

function update-docs {
  local path bucket
  path=$2
  bucket=$1
  aws s3 sync --acl=public-read --delete $path s3://docs.mipadi.com/$bucket
}

function urlencode {
  python -c 'import urllib.parse as P; import sys; print(P.quote(sys.stdin.read()))'
}

# Prints the bash utf8 representation of a character
function utf8 {
  echo -n "$1" \
    | hexdump -b \
    | head -n 1 \
    | awk '{ for (i = 1; ++i <= NF;) printf "\\%s", $i; } END { print " " }'
}

function uuid7 {
    local u=$(date | md5sum)
    echo "${u:0:7}"
}

function vbox-ostypes {
  VBoxManage list ostypes | egrep '^ID:' | awk '{print $2}' | sort
}

function vex {
  if [ ! -d .bundle ]; then
    onoe "No virtualenv in ${PWD}"
    return 1
  fi
  env -P "${PWD}/.bundle/bin" VIRTUAL_ENV="${PWD}/.bundle" $*
}

function vimsyn {
  local ver=$(vim --version | head -n 1 | egrep -o '(7\.[0-9])' | tr -d '.')
  find $(binroot vim)/share/vim/vim${ver}/syntax -name '*.vim' -exec basename {} \;
}

function vv {
  if [ ! -d .bundle ]; then
    onoe "No virtualenv in $(pwd)"
    return 1
  fi
  local vpath="$(pwd)/.bundle"
  export VIRTUAL_ENV="${vpath}"
  export PATH="${vpath}/bin:${PATH}"
  unset ANSIBLE_LIBRARY
  type python
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

function whichsh {
  # Inspired by <https://nil.wallyjones.com/what-shell-am-i-using/>
  lsof -p $$ | tail -n +3 | head -n 1 | awk '{print $NF}'
}

function whither { readlink -f $(which $1); }

function whois { command whois $1 | $PAGER; }

# Finds a class file in a given JAR file
function wjava {
  grep -l "$1" *.jar
}

# Returns the default values for $XDG_* variables
function xdg {
  local v

  if (( $# < 1 )); then
    onoe 'Variable not specified'
    return 1
  fi

  v=$1

  case $v in
    config-dirs)
      echo ${XDG_CONFIG_DIRS:-/etc/xdg};;
    config-home)
      echo ${XDG_CONFIG_HOME:-${HOME}/.config};;
    cache-home)
      echo ${XDG_CACHE_HOME:-${HOME}/.cache};;
    data-dirs)
      echo ${XDG_DATA_DIRS:-/usr/local/share:/usr/share};;
    data-home)
      echo ${XDG_DATA_HOME:-${HOME}/.local/share};;
    runtime-dir)
      if [[ -n $XDG_RUNTIME_DIR ]]; then
        echo $XDG_RUNTIME_DIR
      fi
      ;;
    *)
      onoe 'No such variable: $XDG_'"$(echo -n $v | tr - _ | tr [:lower:] [:upper:])"
      return 2
  esac
}

[ -r "${DOTBASH_OS}/functions.sh" ] && source "${DOTBASH_OS}/functions.sh"
[ -r "${DOTBASH}/functions.user.sh" ] && source "${DOTBASH}/functions.user.sh"

# vim: set ft=bash :
