if hash ghc 2>/dev/null && [ -d ~/.cabal ]; then
  export PATH="${HOME}/.cabal/bin:${PATH}"
fi

if [[ -d ~/.rubies && -d "$LOCAL" ]]; then
  source "${LOCAL}/share/chruby/chruby.sh"
  chruby $(\ls ~/.rubies | tail -n 1)
fi

if [ -d ~/.pythons/Current ]; then
  py_home=$(readlink -f ~/.pythons/Current)
  py_vers=$(basename $py_home)
  py_fam=${py_vers:0:1}
  export PATH="${py_home}/bin:${PATH}"
  [ -d "${py_home}/share/ansible" ] && export ANSIBLE_LIBRARY="${py_home}/share/ansible"
  export TOX_PYTHONS="${HOME}/.pythons"

  if [ ${py_fam} = '3' ]; then
    alias pip='pip3'
    alias python='python3'
    alias virtualenv='pyvenv'
  fi
fi

if [ -d ~/.scalas/Current ]; then
  export SCALA_HOME=$(readlink -f ~/.scalas/Current)
  export PATH="${SCALA_HOME}/bin:${PATH}"
fi

if [ -d ~/.go/Current ]; then
  export GOPATH="${HOME}/.go/ws"
  mkdir -p "$GOPATH"
  export PATH="${GOPATH}/bin:$(readlink -f ~/.go/Current/bin):${PATH}"
fi

if hash node 2>/dev/null; then
  node_modules="$(dirname $(dirname $(which node)))/lib/node_modules"
  if [ -d $node_modules ]; then
    export NODE_PATH="${node_modules}:${NODE_PATH}"
  fi
fi

[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"
