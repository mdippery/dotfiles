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
  echo "brew: $1" 1>&2
}

function brew_prefix {
  [ -n $HOMEBREW ] && echo "$HOMEBREW" || echo '/usr/local'
}

function brew_ls {
  if [ $# -eq 1 ]; then
    local pkg pkgd pkgv
    pkg=$1
    pkgd="$(brew_prefix)/Cellar/${pkg}"
    if [ -d "$pkgd" ]; then
      pkgv=$(ls -r "$(brew_prefix)/Cellar/${pkg}" | head -n 1)
      pkgd="$(brew_prefix)/Cellar/${pkg}/${pkgv}"
      tree "$pkgd"
    else
      _brew_die "no such package: $pkg"
      return 2
    fi
  else
    if [ -d "$(brew_prefix)/Cellar" ]; then
      find "$(brew_prefix)/Cellar" -maxdepth 2 -mindepth 2 -type d | cut -d / -f 8,9 | tr / ' ' | sort | column -t
    fi
  fi
}

function brew {
  case "$1" in
    --prefix)
      shift
      brew_prefix $*
      ;;
    ls)
      shift
      brew_ls $*
      ;;
    *)
      _brew_die 'invalid arguments'
      return 1
  esac
}
