# Should I use $ZDOTDIR here instead? Set ZDOTDIR=$DOTZSH?
export DOTZSH="${HOME}/.config/zsh"

export OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Check /etc/zshrc when configuring zsh, especially on macOS.
# It can set some gnarly options.
# In particular, I might want to set $HISTFILE to $ZDG_STATE_HOME/zsh,
# like my other history files.
# Or if I want to disable it entirely, run `unset HISTFILE` as in bash.
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.
