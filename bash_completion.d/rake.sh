_complete_rake() {
  COMPREPLY=()
  if [ -e ./Rakefile ]; then
    local targets=$(rake -T | awk 'FNR>1' | sed -e 's/^rake //' -e 's/#.*$//' -e 's/[ \t]*$//')
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${targets}" -- ${cur}) )
  fi
}
complete -o bashdefault -o default -F _complete_rake rake
