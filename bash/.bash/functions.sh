function bcat {
  if hash $1 2>/dev/null; then
    less $(which $1)
  else
    which $1
  fi
}

function binroot {
  dirname $(dirname $(which $1))
}

function cabal-platform {
  local arch=$(uname -m)
  local os="$OS"
  if [ "$OS" = 'darwin' ]; then
    os='osx'
  fi
  local ghc=$(ghc --version | awk '{print $(NF)}')
  echo "${arch}-${os}-ghc-${ghc}"
}

function char { echo -n "$1" | hexdump -C; }

function colors {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

function erlp {
  local proj=$1
  mkdir $proj
  mkdir $proj/{ebin,include,priv,src}
  cat > $proj/Emakefile <<EOF
{'src/*', [debug_info,
           {i, "src"},
           {i, "include"},
           {outdir, "ebin"}]}.
EOF
}

function get-pip { wget https://bootstrap.pypa.io/get-pip.py; }

# Returns the HTTP status code for a URL
function hstat { curl -I $1 2>/dev/null | head -1; }

# Show known SSH hosts
function known-hosts {
  cut -d ' ' -f 1 < ~/.ssh/known_hosts | cut -d ',' -f 1 | sort
}

# Creates a go project and link in the current directory
function mkgo {
  if [ -z "$GOPATH" ]; then
    echo '$GOPATH is not set' 1>&2
    return 1
  fi
  if [ $# -lt 1 ]; then
    echo 'Usage: mkgo <url>' 1>&2
    return 2
  fi
  repo=$1
  mkdir -p "$GOPATH/src/$repo"
  ln -s "$GOPATH/src/$repo" $(basename $repo)
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

function uuid7 {
    local u=$(date | md5sum)
    echo "${u:0:7}"
}

function vv {
  if [ ! -d .venv ]; then
    echo "No virtualenv in ${PWD}"
    return 1
  fi
  local venv=$(/bin/ls -1 .venv)
  local vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  vv_prompt $venv
}

function vv_prompt {
  local venv=$1
  export PS1="\[$(tput smul)$(tput setaf 6)\]$venv\[$(tput sgr0)\] $DEFAULT_PS1"
}

function wl { readlink -f $(which $1); }

function whois { /usr/bin/whois $1 | $PAGER; }

# Finds a class file in a given JAR file
function wjava {
  grep -l "$1" *.jar
}

[ -r "${DOTBASH}/functions.${OS}.sh" ] && source "${DOTBASH}/functions.${OS}.sh"
[ -r "${DOTBASH}/functions.user.sh" ] && source "${DOTBASH}/functions.user.sh"
