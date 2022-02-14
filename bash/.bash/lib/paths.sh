function read-paths {
  eval echo $(tr '\n' ':' < $1 | sed 's/:$//')
}
