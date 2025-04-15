if [ -d ~/.rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
  export RUBY_VERSION=$(rbenv version | awk '{print $1}')
fi

if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  alias pyw='pyenv which'
fi
[ -r ~/.poetry/env ] && source ~/.poetry/env
export PYTHONSTARTUP="$(xdg config-home)/python/startup.py"

if [ -d ~/.go/go ]; then
  export GOROOT="${HOME}/.go/go"
  export GOPATH="${HOME}/.go/ws"
  mkdir -p "$GOPATH"
fi

if [ -d ~/.cargo/bin ]; then
  export PATH=${HOME}/.cargo/bin:${PATH}
fi

if [ -d ~/.cabal/bin ]; then
  export PATH=${HOME}/.cabal/bin:${PATH}
fi

if hash node 2>/dev/null; then
  node_modules="$(dirname $(dirname $(which node)))/lib/node_modules"
  if [ -d $node_modules ]; then
    export NODE_PATH="${node_modules}:${NODE_PATH}"
  fi
fi

if [ -s ~/.nvm/nvm.sh ]; then
  export NVM_DIR="${HOME}/.nvm"
  . "${NVM_DIR}/nvm.sh"
fi

[ -r "${XDG_DATA_HOME}/ghcup/env" ] && source "${XDG_DATA_HOME}/ghcup/env"
[ -r "${DOTBASH}/languages.user.sh" ] && source "${DOTBASH}/languages.user.sh"

# vim: set ft=bash :
