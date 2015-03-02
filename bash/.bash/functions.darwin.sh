# Shows all file associations known to LaunchServices
function lsregister-dump {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump
}

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}
