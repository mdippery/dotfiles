# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>


source "${DOTBASH}/lib/prompt.sh"
export PROMPT_COMMAND=_ps1
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

export PATH=$(tr '\n' ':' < "${DOTBASH}/host/${HOSTNAME_HASH}/paths" | sed 's/:$//')
export MANPATH=$(tr '\n' ':' < "${DOTBASH}/host/${HOSTNAME_HASH}/manpaths" | sed 's/:$//')

export LOCAL="${HOME}/.local"
export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

export EDITOR='vim'
export GUI_EDITOR='/usr/local/bin/mvim'
export HOMEBREW_EDITOR="$GUI_EDITOR"
export PAGER='/usr/bin/less'
export LESS='R'

export GPG_TTY=$(tty)

export FIGNORE='DS_Store'

export PIPENV_VENV_IN_PROJECT=true

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi

if hash gradle 2>/dev/null; then
  export GRADLE_HOME="$(dirname $(dirname $(readlink -f $(which gradle))))"
fi

export ANSIBLE_NOCOWS=1
export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export DJANGO_DEBUG=true
export GREP_OPTIONS='--color'
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad

[ -r "${DOTBASH}/plat/${OS}/environment.sh" ] && source "${DOTBASH}/plat/${OS}/environment.sh"
[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"
