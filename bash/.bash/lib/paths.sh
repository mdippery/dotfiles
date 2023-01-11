function paths-helper {
  local BREW RAW_PATH
  local homebrew texbin x11bin whichbin gettext

  if [ $(uname -m) = arm64 ]; then
    homebrew=/opt/homebrew/bin
    BREW=${homebrew}/brew
  else
    BREW=/usr/local/bin/brew
  fi

  [ -d /Library/TeX/texbin ] && texbin=/Library/TeX/texbin
  [ -d /opt/X11/bin ] && x11bin=/opt/X11/bin
  $BREW --prefix --installed gnu-which >/dev/null 1>&1 gnu-which && whichbin=$($BREW --prefix gnu-which)/libexec/gnubin
  $BREW --prefix --installed gettext >/dev/null 1>&1 gettext && gettext=$($BREW --prefix gettext)/bin

  RAW_PATH=$(cat <<EOS
$XDG_BIN_HOME
$(dirname $XDG_BIN_HOME)/libexec/git
$homebrew
$texbin
$x11bin
$whichbin
$gettext
$PATH
EOS
)

  echo "$RAW_PATH" | tr '\n' ':' | sed 's/:$//' | tr -s :
}

# vim: set ft=bash :
