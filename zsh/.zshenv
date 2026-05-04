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

. "${DOTZSH}/environment.zsh"
