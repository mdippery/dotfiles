function blib {
  if command -v $1; then
    otool -L $(which $1)
  else
    which $1
  fi
}

function include_path {
  echo $(xcrun --show-sdk-path)/usr/include
}

function ldd {
  onoe 'I think you mean `otool [-L]`'
  return 1
}

function ls-include {
  ls $* $(include_path)
}

# Converts an .mp3 into an .m4r (ringtone)
function mp32m4r {
  local out
  if [[ $# = 2 ]]; then
    out=$2
  else
    out=${1/.mp3/.m4r}
  fi
  afconvert -o "$out" -q 127 -b 256000 -f m4af -d aac "$1"
}

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}

function sym {
  if command -v $1; then
    nm $(which $1)
  else
    which $1
  fi
}

# vim: set ft=bash :
