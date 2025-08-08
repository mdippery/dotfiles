function paths-helper {
  local BREW RAW_PATH
  local macvim docker homebrew x11bin whichbin gettext libpq

  if [ $(uname -m) = arm64 ]; then
    homebrew=/opt/homebrew/bin
    BREW=${homebrew}/brew
  else
    BREW=/usr/local/bin/brew
  fi

  [ -d "${HOME}/.docker/bin" ] && docker="${HOME}/.docker/bin"

  [ -d /Applications/MacVim.app/Contents/bin ] && macvim=/Applications/MacVim.app/Contents/bin

  [ -d /opt/X11/bin ] && x11bin=/opt/X11/bin

  $BREW --prefix --installed gnu-which >/dev/null 2>&1 && whichbin=$($BREW --prefix gnu-which)/libexec/gnubin
  $BREW --prefix --installed gettext >/dev/null 2>&1 && gettext=$($BREW --prefix gettext)/bin

  # Nowadays I normally run Postgres in Docker, so I only install libpq
  # to get access to the `psql` binary.
  $BREW --prefix --installed libpq >/dev/null 2>&1 && libpq=$($BREW --prefix libpq)/bin

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
$PATH
EOS
)

  echo "$RAW_PATH" | tr '\n' ':' | sed 's/:$//' | tr -s :
}

# vim: set ft=bash :
