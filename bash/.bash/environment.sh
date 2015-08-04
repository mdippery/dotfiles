# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>

function _setps1 {
  local s=$1
  local color=$2
  echo -ne "\[$(tput setaf $color)\]$s\[\$(tput sgr0)\] \[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\] "
}

export DEFAULT_PS1="$(_setps1 \\W 4)"
export PS1="$DEFAULT_PS1"
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

if [ -d /usr/local/heroku ]; then
  export PATH="/usr/local/heroku/bin:${PATH}"
fi

export PATH="${HOME}/.local/bin:${PATH}"
export MANPATH="$(brew --prefix erlang)/lib/erlang/man:${MANPATH}"

export LOCAL="${HOME}/.local"
export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

export EDITOR='vim'
export GUI_EDITOR='/usr/local/bin/mvim'
export HOMEBREW_EDITOR="$GUI_EDITOR"
export PAGER='/usr/bin/less'
export LESS='R'

export FIGNORE='DS_Store'

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi

if hash gradle 2>/dev/null; then
  export GRADLE_HOME="$(dirname $(dirname $(readlink -f $(which gradle))))"
fi

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true
export ANSIBLE_NOCOWS=1
export HOMEBREW_NO_EMOJI=1

if [ $OS = 'linux' ]; then
  if [ -z "$TMUX" ]; then
    export TERM='xterm-256color'
  fi
  export GUI_EDITOR='gvim'
  unset HOMEBREW_EDITOR
fi

[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"
