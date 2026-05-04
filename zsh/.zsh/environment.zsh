##############################################################################
# Check /etc/zshrc when configuring zsh, especially on macOS.
# It can set some gnarly options.
# It also sets some environment variables which should be really be set
# in /etc/zshenv, which means they have to be overridden or unset in
# ~/.zshrc, since /etc/zshrc is sourced after ~/.zshenv. Bad, macOS!
#
#
# In particular, I might want to set $HISTFILE to $ZDG_STATE_HOME/zsh,
# like my other history files.
#
# Or if I want to disable it entirely, run `unset HISTFILE` as in bash.
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.
##############################################################################

# $TERM is not always set in zsh -- make sure we set it early.
[ -z "$TERM" ] && export TERM='xterm-256color'

. "${DOTZSH}/xdg.zsh"

export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

[ -r "${DOTZSH_PLAT}/environment.zsh" ] && . "${DOTZSH_PLAT}/environment.zsh"
[ -r "${DOTZSH}/environment.user.zsh" ] && . "${DOTZSH}/environment.user.zsh"
