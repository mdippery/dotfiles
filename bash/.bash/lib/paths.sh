function _default_path {
  # macOS adds a lot of crap to the $PATH that I really don't need.
  if [ $OS = darwin ]; then
    echo /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
  else
    echo $PATH
  fi
}

function _quick_brew_home {
  if [ $(uname -m) = arm64 ]; then
    echo /opt/homebrew
  else
    echo /usr/local
  fi
}

function _quick_brew_prefix {
  echo "$(_quick_brew_home)/opt/$1"
}

function _quick_brew_installed {
  test -e $(_quick_brew_prefix $1)
}

function paths-helper {
  local RAW_PATH
  local macvim docker homebrew x11bin whichbin gettext libpq

  [ -n "$(find ~/.docker/bin -type f -maxdepth 1)" ] && docker="${HOME}/.docker/bin"

  [ -d /Applications/MacVim.app/Contents/bin ] && macvim=/Applications/MacVim.app/Contents/bin

  [ -d /opt/X11/bin ] && x11bin=/opt/X11/bin

  homebrew=$(_quick_brew_home)/bin

  $(_quick_brew_installed gnu-which) && whichbin=$(_quick_brew_prefix gnu-which)/libexec/gnubin
  $(_quick_brew_installed gettext) && gettext=$(_quick_brew_prefix gettext)/bin

  # Nowadays I normally run Postgres in Docker, so I only install libpq
  # to get access to the `psql` binary.
  $(_quick_brew_installed libpq) && libpq=$(_quick_brew_prefix libpq)/bin

  RAW_PATH=$(cat <<EOS
$XDG_BIN_HOME
$(dirname $XDG_BIN_HOME)/libexec/git
$macvim
$docker
$homebrew
$x11bin
$whichbin
$gettext
$libpq
$(_default_path)
EOS
)

  echo "$RAW_PATH" | tr '\n' ':' | sed 's/:$//' | tr -s :
}

# vim: set ft=bash :
