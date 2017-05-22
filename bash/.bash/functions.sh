function airport-code {
  curl -s "https://iatacodes.org/api/v6/airports?api_key=356cad88-f3a3-4a7e-aeec-fad56d838158&code=$1" \
    | jq .response[0].name \
    | tr -d '"'
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

# Reads a .env file into variables
function dotenv {
  set -a
  source .env
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
  curl -s $1 | $expand | tar xf -
}

function get-pip { wget https://bootstrap.pypa.io/get-pip.py; }

function grab-line { sed -n "$1 p"; }

function greet {
  # Assumes cowthink and lolcat are both installed. If they are not, add
  #   alias cowthink='cat'
  #   alias lolcat='cat'
  # to your local ~/.bashrc file.

  if [ -r /etc/motd ]; then
    lolcat < /etc/motd
  elif hash figlet 2>/dev/null; then
    figlet -f slant 'o m g !' | lolcat
  elif hash ddate 2>/dev/null; then
    ddate | cowthink | lolcat
  elif ! alias cowthink 2>/dev/null; then
    uptime | ([[ $OS == 'darwin' ]] && tail -c +8 || cat) | cowthink -n | lolcat
  else
    echo "$(hostname -s)?" | cowthink | lolcat
  fi
}

# Returns IP data for a given host
function hostinfo {
  for ip in $(hostip $1); do
    ipinfo $ip
  done
}

# Returns the IP address for a given host
function hostip { host $1 | command grep 'has address' | awk '{ print $4 }'; }

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

# Creates a new folder and cd's into it
function mkcd {
  mkdir -pv "${1:?}" && cd "$1"
}

# Upgrades outdated pip dependencies
function pip-outdated {
  pip list -o | cut -d ' ' -f 1 | xargs pip install -U
}

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

function py3-alias {
  if ! pyenv which python3 2>/dev/null; then
    onoe "You are using $(python -V 2>&1)!"
    return 1
  fi
  local py_home=$(python3 -c 'import sys; print(sys.prefix)')
  local py_bin="${py_home}/bin"
  for bin in $(find "$py_bin" -name '*3'); do
    local bin_name=$(basename $bin)
    local alias_name=${bin_name%3}
    if [[ $bin_name != '2to3' ]]; then
      echo -n "Aliasing ${alias_name} to ${bin_name}... "
      alias ${alias_name}=${bin_name}
      echo 'ok'
    fi
  done
  echo -n 'Aliasing virtualenv to pyvenv... '
  alias virtualenv=pyvenv
  echo 'ok'
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

# Prints the python path
function pypath {
  python -c 'import sys; print("\n".join(sys.path))' \
    | sed 's/^$/\./g'
}

# Prints the python prefix
function pyprefix {
  python -c 'import sys; print(sys.prefix)'
}

# Repeats a character a given number of times
function repeat {
  local ch=$1
  local n=$2
  printf %${n}s | tr ' ' $ch
}

# Does a reverse DNS lookup on an IP
function rvdns { nslookup $1 | awk '/name = .*\.$/ {print $4}' | sed 's/\.$//'; }

function trim { cut -c-$(tput cols); }

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

function vimsyn {
  local ver=$(vim --version | head -n 1 | egrep -o '(7\.[0-9])' | tr -d '.')
  find $(binroot vim)/share/vim/vim${ver}/syntax -name '*.vim' -exec basename {} \;
}

function vv {
  if [ ! -d .venv ]; then
    onoe "No virtualenv in ${PWD}"
    return 1
  fi
  local venv=$(command ls -1 .venv)
  local vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  unset ANSIBLE_LIBRARY
  vv_prompt $venv
}

function vv_prompt {
  export PS1="\[$(tput setaf 6)\]\342\226\266\[$(tput sgr0)\] $DEFAULT_PS1"
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

[ -r "${DOTBASH}/plat/${OS}/functions.sh" ] && source "${DOTBASH}/plat/${OS}/functions.sh"
[ -r "${DOTBASH}/functions.user.sh" ] && source "${DOTBASH}/functions.user.sh"
