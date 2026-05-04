# Don't save history.
#
# /etc/zshrc also sets HISTSIZE and SAVEHIST, so those need to be overidden
# here if I ever enable history. And I may want to set HISTFILE to
# $ZDG_STATE_HOME/zsh, like my other history files.
#
# Lots of other great options to look at, like $HIST_IGNORE_SPACE and
# $HIST_IGNORE_DUPS; see `man zshoptions` for more settings.

unset HISTFILE
