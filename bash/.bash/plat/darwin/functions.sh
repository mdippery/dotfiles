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

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}
