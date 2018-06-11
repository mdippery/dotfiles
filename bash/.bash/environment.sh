# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>


source "${DOTBASH}/lib/prompt.sh"
export PROMPT_COMMAND=_ps1
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

PATHS_FILE="${DOTBASH}/host/${HOSTNAME_HASH}/paths"
MANPATHS_FILE="${DOTBASH}/host/${HOSTNAME_HASH}/manpaths"
[ -r "$PATHS_FILE" ] && export PATH=$(tr '\n' ':' < "$PATHS_FILE" | sed 's/:$//')
[ -r "$MANPATHS_FILE" ] && export MANPATH=$(tr '\n' ':' < "$MANPATHS_FILE" | sed 's/:$//')

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export LOCAL="${HOME}/.local"
export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

export EDITOR='vim'
export GUI_EDITOR='mvim'
export HOMEBREW_EDITOR="$GUI_EDITOR"

export PAGER='/usr/bin/less'
export LESS='R'

export ANSIBLE_NOCOWS=1
export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export DJANGO_DEBUG=true
export FIGNORE='DS_Store'
export GPG_TTY=$(tty)
export GREP_OPTIONS='--color'
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export PIPENV_VENV_IN_PROJECT=true

[ -x /usr/libexec/java_home ] && \
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

[ -r "${DOTBASH}/plat/${OS}/environment.sh" ] && source "${DOTBASH}/plat/${OS}/environment.sh"
[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"
