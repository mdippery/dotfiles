_complete_fabric() {
  COMPREPLY=()
  if [ -e ./fabfile.py ]; then
    local targets=$(fab -l | sed '1,2d' | awk '{print $1}')
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${targets}" -- ${cur}) )
  fi
}
complete -o bashdefault -o default -F _complete_fabric fab
