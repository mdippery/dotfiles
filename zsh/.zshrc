# Don't save history.
#
# We have to set history settings in .zshrc instead of .zshenv because
# macOS sets them in /etc/zshrc, which runs after .zshenv. Bad, macOS!
#
# It also sets HISTSIZE and SAVEHIST, so those need to be overidden here,
# too, if I ever enable history.
#
# If I ever enable history, I may want to set HISTFILE to $ZDG_STATE_HOME/zsh,
# like my other history files.
#
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.

unset HISTFILE
