if [[ -d ~/.rbenv ]]; then
  eval "$(rbenv init -)"
  export RUBY_VERSION=$(rbenv version | awk '{print $1}')
fi

if [[ -d ~/.pyenv ]]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  eval "$(pyenv init -)"
fi
export PYTHONSTARTUP="$(xdg config-home)/python/startup.py"

if [ -d ~/.scalas/Current ]; then
  export SCALA_HOME=$(readlink -f ~/.scalas/Current)
fi

if [ -d ~/.go/go ]; then
  export GOROOT="${HOME}/.go/go"
  export GOPATH="${HOME}/.go/ws"
  mkdir -p "$GOPATH"
fi

if hash node 2>/dev/null; then
  node_modules="$(dirname $(dirname $(which node)))/lib/node_modules"
  if [ -d $node_modules ]; then
    export NODE_PATH="${node_modules}:${NODE_PATH}"
  fi
fi

[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"
