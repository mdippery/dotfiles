function bcat {
  if hash $1 2>/dev/null; then
    less $(which $1)
  else
    which $1
  fi
}

function binroot {
  if (( $# < 1 )); then
    echo 'binroot <path>' 1>&2
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
    echo 'GHC is not installed' 1>&2
    return 1
  fi
}

function char { echo -n "$1" | hexdump -C; }

function colors {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

function get-pip { wget https://bootstrap.pypa.io/get-pip.py; }

function greet {
  # Assumes cowthink and lolcat are both installed. If they are not, add
  #   alias cowthink='cat'
  #   alias lolcat='cat'
  # to your local ~/.bashrc file.

  if [ -r /etc/motd ]; then
    lolcat < /etc/motd
  elif hash ddate 2>/dev/null; then
    ddate | cowthink | lolcat
  elif ! alias cowthink 2>/dev/null; then
    uptime | ([[ $OS == 'darwin' ]] && tail -c +8 || cat) | cowthink -n | lolcat
  else
    echo "$(hostname -s)?" | cowthink | lolcat
  fi
}

# Returns the IP address for a given host
function hostip { host $1 | head -n 1 | awk '{ print $4 }'; }

# Returns the HTTP status code for a URL
function hstat { curl -I $1 2>/dev/null | head -1; }

# Show known SSH hosts
function known-hosts {
  cut -d ' ' -f 1 < ~/.ssh/known_hosts | cut -d ',' -f 1 | sort
}

# Creates a new folder and cd's into it
function mkcd {
  mkdir -pv "${1:?}" && cd "$1"
}

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

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
    echo "No virtualenv in ${PWD}"
    return 1
  fi
  local venv=$(\ls -1 .venv)
  local vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  vv_prompt $venv
}

function vv_prompt {
  local venv=$1
  export PS1="\[$(tput setaf 6)\]\342\226\266\[$(tput sgr0)\] $DEFAULT_PS1"
}

function whither { readlink -f $(which $1); }

function whois { /usr/bin/whois $1 | $PAGER; }

# Finds a class file in a given JAR file
function wjava {
  grep -l "$1" *.jar
}

[ -r "${DOTBASH}/plat/${OS}/functions.sh" ] && source "${DOTBASH}/plat/${OS}/functions.sh"
[ -r "${DOTBASH}/functions.user.sh" ] && source "${DOTBASH}/functions.user.sh"
