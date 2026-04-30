export DOTBASH="${HOME}/.bash"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTBASH_PLAT="${DOTBASH}/plat/${OS}"

# We need to source these as early as possible because they are used
# pervasively over our bash config.
source "${DOTBASH}/xdg.sh"

unset HISTFILE                  # Don't save history
export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'
shopt -s histappend
# If I ever want to enable history again, setting
#   SHELL_SESSION_HISTORY=0
# should disable per-session history files (which I hate),
# although ~/.bash_sessions_disable might already do that.
# Check /etc/bashrc_Apple_Terminal on macOS for details.
# I might also want to set $HISTFILE to go to $XDG_STATE_HOME/bash,
# like my other history files.

unalias -a                      # I don't want any pre-set aliases

[ -r "${DOTBASH}/lib.sh" ] && source "${DOTBASH}/lib.sh"

source "${DOTBASH}/environment.sh"
source "${DOTBASH}/functions.sh"
source "${DOTBASH}/aliases.sh"
source "${DOTBASH}/languages.sh"
source "${DOTBASH}/completion.sh"

[ -r "${HOME}/.bashrc.user" ] && source "${HOME}/.bashrc.user"
