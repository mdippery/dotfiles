if hash rbenv 2>/dev/null; then
  export PATH="${HOME}/.rbenv_bin:${PATH}"
  eval "$(rbenv init -)"
  export RUBY_VERSION=$(rbenv version | awk '{print $1}')
fi

if hash pyenv 2>/dev/null; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  evan "$(pyenv init --path)"
  eval "$(pyenv init -)"
  alias pyw='pyenv which'
fi
[ -d "${HOME}/.poetry/bin" ] && export PATH="${HOME}/.poetry/bin:${PATH}"
export PYTHONSTARTUP="$(xdg config-home)/python/startup.py"

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

[ -r "${XDG_DATA_HOME}/ghcup/env" ] && source "${XDG_DATA_HOME}/ghcup/env"
[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"

# vim: set ft=bash :
