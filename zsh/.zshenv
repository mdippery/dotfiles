##############################################################################
# THIS FILE MUST BE AT ~/.zshenv!
# We can set $ZDOTDIR to move ~/.zprofile, ~/.zshrc, etc., to, e.g.,
# ~/.config/zsh, but ~/.zshenv is read immediately when zsh starts,
# and is thus responsible for setting `$ZDOTDIR`, so it has to remain
# in the root of the home folder.
##############################################################################

export DOTZSH="${HOME}/.config/zsh"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTZSH_PLAT="${DOTZSH}/plat/${OS}"
#export ZDOTDIR=$DOTZSH

. "${DOTZSH}/xdg.zsh"

# Check /etc/zshrc when configuring zsh, especially on macOS.
# It can set some gnarly options.
# In particular, I might want to set $HISTFILE to $ZDG_STATE_HOME/zsh,
# like my other history files.
# Or if I want to disable it entirely, run `unset HISTFILE` as in bash.
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.


[ -r "${DOTZSH}/environment.zsh" ] && . "${DOTZSH}/environment.zsh"
