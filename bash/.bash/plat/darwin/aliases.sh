alias binld='blib'
alias dec='otool -tvV -use-color'
alias dis='dec'
alias linux-sh='docker run --rm -it ubuntu:xenial'
alias lsusb='system_profiler SPUSBDataType'

if command -v fd &>/dev/null; then
  alias fd='LS_COLORS="$(fdcolors)" fd'
  alias fdcolors="paste -sd : $XDG_CONFIG_HOME/fd/fdcolors"
fi
