export DOTBASH="${HOME}/.bash"
export DOTBASH_OS=$(uname -s | tr '[:upper:]' '[:lower:]')

export XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/Library/Caches}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_CACHE_HOME}

unset HISTFILE                  # Don't save history
export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

source "${DOTBASH}/lib.sh"

source "${DOTBASH}/environment.sh"
source "${DOTBASH}/functions.sh"
source "${DOTBASH}/aliases.sh"
source "${DOTBASH}/languages.sh"
source "${DOTBASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
