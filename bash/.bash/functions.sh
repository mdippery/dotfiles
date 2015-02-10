# Recreate behavior of GNU `readlink` on OS X
if [ $OS = 'darwin' ]; then
  if hash greadlink 2>/dev/null; then
    alias readlink='greadlink'
  else
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
  fi
fi

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

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

# Does a reverse DNS lookup on an IP
function rvdns { nslookup $1 | awk '/name = .*\.$/ {print $4}' | sed 's/\.$//'; }

function uuid7 {
    u=$(date | md5sum)
    echo "${u:0:7}"
}

function vv {
  if [ ! -d .venv ]; then
    echo "No virtualenv in ${PWD}"
    return 1
  fi
  venv=$(/bin/ls -1 .venv)
  vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  export PS1="\[$(tput setaf 3)\]\342\206\252\357\270\216\[$(tput sgr0)\]  "
  export PS2="$(echo $PS2 | tr -d ' ')  "
}

function whois { /usr/bin/whois $1 | $PAGER; }

function wjava {
  grep -l "$1" *.jar
}

[ -r "${BASH}/functions.user.sh" ] && source "${BASH}/functions.user.sh"
