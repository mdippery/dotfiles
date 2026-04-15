export DOTBASH="${HOME}/.bash"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTBASH_PLAT="${DOTBASH}/plat/${OS}"

# We need to source these as early as possible because they are used
# pervasively over our bash config.
source "${DOTBASH}/xdg.sh"
[ -r "${DOTBASH_PLAT}/xdg.sh" ] && source "${DOTBASH_PLAT}/xdg.sh"

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
