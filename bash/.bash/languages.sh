if [ -d ~/.cabal ]; then
  export PATH="${HOME}/.cabal/bin:${PATH}"
fi

if [ -d ~/.rubies -a -d "$LOCAL" ]; then
  source "${LOCAL}/share/chruby/chruby.sh"
  chruby $(/bin/ls ~/.rubies | tail -n 1)
fi

if [ -d ~/.pythons/Current ]; then
  py_home=$(readlink -f ~/.pythons/Current)
  py_vers=$(basename $py_home)
  py_fam=${py_vers:0:1}
  export PATH="${py_home}/bin:${PATH}"
  export ANSIBLE_LIBRARY="${py_home}/share/ansible"
  export TOX_PYTHONS="${HOME}/.pythons"

  if [ ${py_fam} = '3' ]; then
    alias pip='pip3'
    alias python='python3'
    alias ve='pyvenv'
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

[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"
