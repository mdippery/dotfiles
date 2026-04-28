# We have to set history settings in .zshrc instead of .zshenv because
# macOS sets them in /etc/zshrc, which runs after .zshenv. Bad, macOS!
. "${DOTZSH}/lib/history.zsh"
