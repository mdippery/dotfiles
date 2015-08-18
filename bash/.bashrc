export DOTBASH="${HOME}/.bash"

export OS=$(uname -s | tr '[:upper:]' '[:lower:]')

export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'
shopt -s histappend

set -o physical

unalias -a                      # I don't want any pre-set aliases

source "${DOTBASH}/lib.sh"

source "${DOTBASH}/environment.sh"
source "${DOTBASH}/functions.sh"
source "${DOTBASH}/aliases.sh"
source "${DOTBASH}/languages.sh"
source "${DOTBASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
