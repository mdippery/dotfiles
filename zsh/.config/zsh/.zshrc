# We have to set history settings in .zshrc instead of .zshenv because
# macOS sets them in /etc/zshrc, which runs after .zshenv. Bad, macOS!
# It also sets HISTSIZE and SAVEHIST, so those need to be overidden here,
# too, if I ever enable history.
unset HISTFILE  # Don't save history
