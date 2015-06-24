# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}

# Displays desktop resolution
function res {
  osascript -e 'tell application \"Finder\" to get bounds of window of desktop' \
    | cut -d, -f 3,4 \
    | sed 's/, /x/' \
    | tr -d ' '
}
