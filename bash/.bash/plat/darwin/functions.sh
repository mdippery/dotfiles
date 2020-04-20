# Sometimes Xcode upgrades don't install header files in /usr/include properly
function install-missing-headers {
  local dir=/Library/Developer/CommandLineTools/Packages
  local pkg=$(ls -t1 $dir | head -n 1)
  open "$dir/$pkg"
}

function ldd {
  onoe 'I think you mean `otool [-L]`'
  return 1
}

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}
