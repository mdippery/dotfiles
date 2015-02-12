export BASH="${HOME}/.bash"

export HISTCONTROL=ignoredups
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

source "${BASH}/lib.sh"

source "${BASH}/environment.sh"
source "${BASH}/aliases.sh"
source "${BASH}/functions.sh"
source "${BASH}/languages.sh"
source "${BASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
