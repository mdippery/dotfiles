function ldd {
  onoe 'I think you mean `otool [-L]`'
  return 1
}

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}
