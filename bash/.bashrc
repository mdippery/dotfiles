export DOTBASH="${HOME}/.bash"

hash md5sum 2>/dev/null || function md5sum { /sbin/md5; }

export DOTBASH_HOSTNAME_HASH=$(hostname | md5sum | awk '{ print $1 }')
export DOTBASH_OS=$(uname -s | tr '[:upper:]' '[:lower:]')

if [ -r /etc/redhat-release ]; then
  DOTBASH_SYS="centos$(egrep -o 'CentOS (Linux )?release [0-9]+' /etc/redhat-release  | awk '{print $NF}')"
else
  DOTBASH_SYS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi
export DOTBASH_SYS

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/Library/Caches}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

unset HISTFILE                  # Don't save history
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
