# A poor-man's version of Mac OS X's excellent `brew` script.
# To use, source this from ~/.bashrc or equivalent.
#
# It is designed to provide some of the same basic functionality
# as `brew`, so that `brew` can be used in bash scripts even on
# systems that don't have Homebrew installed.
#
# It assumes that there is a /brew directory or symlink on the
# system, but will default to /usr/local in the absence of such
# a path.

function _brew_die {
  onoe "brew: $1"
}

function _brew_guess_package {
  local dir=$(basename $1)
  echo "$dir" | awk -F - '{ print $1 }'
}

function brew_cache {
  echo ${HOMEBREW_CACHE:-/tmp}
}

function brew_cellar {
  if (( $# == 0 )); then
    echo "$(brew --prefix)/Cellar"
  elif (( $# == 1 )); then
    echo "$(brew --prefix)/Cellar/${1}"
  else
    _brew_die 'only one package may be specified at a time'
  fi
}

function brew_diy {
  local pkg
  if (( $# == 1 )); then
    pkg=$1
  else
    pkg=$(_brew_guess_package $(pwd))
  fi
  if [[ -z $pkg ]]; then
    _brew_die 'no package specified'
    return 1
  fi
  brew --cellar $pkg
}

function brew_link {
  stow -d $(brew --cellar) $*
}

function brew_ls {
  if (( $# == 1 )); then
    local pkg pkgd pkgv
    pkg=$1
    pkgd="$(brew_prefix)/Cellar/${pkg}"
    if [ -d "$pkgd" ]; then
      tree "$pkgd"
    else
      _brew_die "no such package: $pkg"
      return 2
    fi
  else
    if [ -d "$(brew_prefix)/Cellar" ]; then
      command ls -1 $(brew --cellar)
    fi
  fi
}


function brew_prefix {
  echo ${HOMEBREW:-/usr/local}
}


function brew_uninstall {
  brew_unlink $1
  command rm -rf $(brew --cellar $1)
}

function brew_unlink {
  stow -d $(brew --cellar) -D $*
}

function brew {
  case "$1" in
    --cache)
      shift
      brew_cache $*
      ;;
    --cellar)
      shift
      brew_cellar $*
      ;;
    --prefix)
      shift
      brew_prefix $*
      ;;
    diy)
      shift
      brew_diy $*
      ;;
    link)
      shift
      brew_link $*
      ;;
    ln)
      shift
      brew_link $*
      ;;
    ls)
      shift
      brew_ls $*
      ;;
    rm)
      shift
      brew_uninstall $*
      ;;
    uninstall)
      shift
      brew_uninstall $*
      ;;
    unlink)
      shift
      brew_unlink $*
      ;;
    *)
      _brew_die 'invalid arguments'
      return 1
  esac
}
