function manpaths-helper {
  export MANPATHS_FILE="$(dotbash sys)/manpaths"
  if [ -r "$MANPATHS_FILE" ]; then
    read-paths $MANPATHS_FILE
  else
    echo $MANPATH
  fi
}

function paths-helper {
  export PATHS_FILE="$(dotbash sys)/paths"
  if [ -r "$PATHS_FILE" ]; then
    read-paths $PATHS_FILE
  else
    echo $PATH
  fi
}

function read-paths {
  eval echo $(tr '\n' ':' < $1 | sed 's/:$//')
}
