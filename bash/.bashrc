export DOTBASH="${HOME}/.bash"

export DOTBASH_HOSTNAME_HASH=$(hostname | md5sum | awk '{ print $1 }')
export DOTBASH_OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTBASH_SYS="centos$(egrep -o 'CentOS (Linux )?release [0-9]+' /etc/redhat-release  | awk '{print $NF}')"   # TODO: Detect macos

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export HISTFILE="${XDG_CACHE_HOME}/bash/history/$(hostname)"
mkdir -p -m 0700 $(dirname "$HISTFILE")
export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

source "${DOTBASH}/lib.sh"

source "$(dotbash)/environment.sh"
source "$(dotbash)/functions.sh"
source "$(dotbash)/aliases.sh"
source "$(dotbash)/languages.sh"
source "$(dotbash)/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
