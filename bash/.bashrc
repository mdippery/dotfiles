export BASH="${HOME}/.bash"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')

export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

source "${BASH}/lib.sh"

source "${BASH}/environment.sh"
source "${BASH}/aliases.sh"
source "${BASH}/functions.sh"
source "${BASH}/languages.sh"
source "${BASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
