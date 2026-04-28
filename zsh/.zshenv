##############################################################################
# THIS FILE MUST BE AT ~/.zshenv!
# We can set $ZDOTDIR to move ~/.zprofile, ~/.zshrc, etc., to, e.g.,
# ~/.config/zsh, but ~/.zshenv is read immediately when zsh starts,
# and is thus responsible for setting `$ZDOTDIR`, so it has to remain
# in the root of the home folder.
##############################################################################

# Check /etc/zshrc when configuring zsh, especially on macOS.
# It can set some gnarly options.
# In particular, I might want to set $HISTFILE to $ZDG_STATE_HOME/zsh,
# like my other history files.
# Or if I want to disable it entirely, run `unset HISTFILE` as in bash.
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.

export DOTZSH="${HOME}/.config/zsh"
export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTZSH_PLAT="${DOTZSH}/plat/${OS}"
#export ZDOTDIR=$DOTZSH

. "${DOTZSH}/xdg.zsh"

# Disable shell session support on macOS.
#
# On macOS, /etc/zshrc calls /etc/zshrc_Apple_Terminal, which manages the
# saving and loading of sessions. I hate sessions -- I want everything to
# disappear when I close the Terminal -- so I like to disable these.
# Unfortunately, this environment variable MUST be set in ~/.zprofile, because
# it needs to be set BEFORE /etc/zshrc is loaded.
#
# See [1] for general discussion.
#
# [1]: https://superuser.com/q/1610587
#
# TODO: Move this to a plat/darwin directory when one becomes available.
if [ -e /etc/zshrc_Apple_Terminal ]; then
  export SHELL_SESSIONS_DISABLE=1
fi

[ -r "${DOTZSH}/environment.zsh" ] && . "${DOTZSH}/environment.zsh"
