function netinfo {
  ifconfig eth0 | command grep -E -o 'inet addr:[^ ]+' | awk -F: '{print $2}'
  ifconfig eth0 | command grep -E -o 'HWaddr .+$' | awk '{print $2}'
}

# Recreate OS X's `otool -L` on Linux
function otool {
  if (( $# < 1 )) || [[ $1 != '-L' ]]; then
    local cmd='ldd'
    if (( $# > 0 )); then
      cmd="$cmd $*"
    fi
    echo "I think you mean \`$cmd\`" 2>&1
    return 1
  fi
  shift
  ldd "$1"
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
