if hash ghc 2>/dev/null && [ -d ~/.cabal ]; then
  export PATH="${HOME}/.cabal/bin:${PATH}"
fi

if [[ -d ~/.rbenv ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
  export RUBY_VERSION=$(rbenv version | awk '{print $1}')
fi

if [[ -d ~/.pyenv ]]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
fi
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-${HOME}/.config}/python/startup.py"

if [ -d ~/.scalas/Current ]; then
  export SCALA_HOME=$(readlink -f ~/.scalas/Current)
  export PATH="${SCALA_HOME}/bin:${PATH}"
fi

if [ -d ~/.go/go ]; then
  export GOROOT="${HOME}/.go/go"
  export GOPATH="${HOME}/.go/ws"
  mkdir -p "$GOPATH"
  export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"
fi

if hash node 2>/dev/null; then
  node_modules="$(dirname $(dirname $(which node)))/lib/node_modules"
  if [ -d $node_modules ]; then
    export NODE_PATH="${node_modules}:${NODE_PATH}"
  fi
fi

[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"
