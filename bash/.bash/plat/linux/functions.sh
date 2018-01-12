function cpuinfo {
  lscpu | command egrep 'Thread|Core|Socket|^CPU\('
}

function netinfo {
  ifconfig eth0 | command grep -E -o 'inet addr:[^ ]+' | awk -F: '{print $2}'
  ifconfig eth0 | command grep -E -o 'HWaddr .+$' | awk '{print $2}'
}

function otool {
  onoe 'I think you mean \`ldd\`'
  return 1
}

function ripcd {
  cdparanoia -vsQ

  read -p 'Continue? [Y/n] ' -n 1 -r
  echo
  if [[ ! $REPLY == 'Y' ]]; then
    return 1
  fi

  echo 'Ripping CD...'
  cdparanoia -B

  echo 'Converting to MP3 VBR V0...'
  for wav in *.wav; do
    lame -V 0 -B 320 $wav $wav.mp3
  done

  echo 'Tarring MP3s...'
  tar cf "${PWD##*/}.tar" *.mp3

  echo 'Done!'
}

# Outputs the rpath for a given library
function rpath {
  local obj=$1
  readelf -d "$obj" \
    | command egrep '\(RPATH\)\s+Library rpath: \[(.+)\]' \
    | awk -F[ '{ print $2 }' \
    | sed 's/]$//g'
}
