# environment.zsh mirrors my long-standing bash setup, but it might make
# more sense to merge this file with ~/.zshenv, since zsh already has its
# own separate environment file.

export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

[ -r "${DOTZSH_PLAT}/environment.zsh" ] && . "${DOTZSH_PLAT}/environment.zsh"
[ -r "${DOTZSH}/user/environment.zsh" ] && . "${DOTZSH}/user/environment.zsh"
