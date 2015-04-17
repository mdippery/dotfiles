export BASHRC="${HOME}/.bash"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')

export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

source "${BASHRC}/lib.sh"

source "${BASHRC}/environment.sh"
source "${BASHRC}/functions.sh"
source "${BASHRC}/aliases.sh"
source "${BASHRC}/languages.sh"
source "${BASHRC}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
