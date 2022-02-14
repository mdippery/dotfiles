function paths-helper {
  local BREW RAW_PATH
  local homebrew texbin x11bin whichbin gettext

  if [ -d /opt/homebrew/bin ]; then
    BREW=/opt/homebrew/bin/brew
  else
    BREW=brew
  fi

  [ -d /opt/homebrew/bin ] && homebrew=/opt/homebrew/bin
  [ -d /Library/TeX/texbin ] && texbin=/Library/TeX/texbin
  [ -d /opt/X11/bin ] && x11bin=/opt/X11/bin
  $BREW --prefix --installed >/dev/null 1>&1 gnu-which && whichbin=$($BREW --prefix gnu-which)/libexec/gnubin
  $BREW --prefix --installed >/dev/null 1>&1 gettext && gettext=$($BREW --prefix gettext)/bin

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
