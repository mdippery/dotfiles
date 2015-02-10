export BASH="${HOME}/.bash"

export HISTCONTROL=ignoredups
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

# Parts of the bash config scripts rely on `brew`, which is only installed
# on my Macs. Instead of wrapping a lot of the logic in conditionals
# that check for the presence of `brew`, provide a fake one if it is
# not installed.
if ! hash brew 2>/dev/null; then
  function brew {
    echo "${OPT:-/usr/local}"
  }
fi

source "${BASH}/environment.sh"
source "${BASH}/aliases.sh"
source "${BASH}/functions.sh"
source "${BASH}/languages.sh"
source "${BASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
