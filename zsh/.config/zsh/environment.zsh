setopt NO_GLOBAL_RCS

export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export HOSTNAME_HASH=$(hostname | md5sum | awk '{print $1 }')

export PATH=$(cat "${DOTZSH}/host/${HOSTNAME_HASH}/paths" | tr '\n' ':' | sed 's/:$//')

export LOCAL=$(dirname $XDG_DATA_HOME)
export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

export EDITOR='vim'
export GUI_EDITOR='gvim'
export HOMEBREW_EDITOR=$GUI_EDITOR

export PAGER='/usr/bin/less'
export LESS='R'

export ANSIBLE_NOCOWS=1
export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export DJANGO_DEBUG=true
export FIGNORE='DS_Store'
export GREP_OPTIONS='--color'
export GPG_TTY=$(tty)
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
export NETHACKOPTIONS=''
export PIPENV_VENV_IN_PROJECT=true

[ -x /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

hash gradle 2>/dev/null && export GRADLE_HOME="$(dirname $(dirname $(readlink -f $(which gradle))))"

[ -r "${DOTZSH}/plat/${OS}/environment.sh" ] && . "${DOTZSH}/plat/${OS}/environment.zsh"
[ -r "${DOTZSH}/user/environment.sh" ] && . "${DOTZSH}/user/environment.zsh"
