# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>

function _ps1_str {
  local s=$1
  local color=$2
  echo -ne "\[$(tput setaf $color)\]$s\[$(tput sgr0)\] \[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\] "
}

function _ps1 {
  local pushed_dirs git_branch venv

  if (( $(dirs -v | wc -l) > 1 )); then
    pushed_dirs="\[$(tput setaf 1)\]+\[$(tput sgr0)\] "
  fi

  if [ -n "$VIRTUAL_ENV" ]; then
    venv="\[$(tput setaf 6)\]\342\226\266\[$(tput sgr0)\] "
  fi

  if git rev-parse --git-dir >/dev/null 2>&1; then
    git_branch='↯'
    if git diff-index --quiet HEAD; then
      git_branch="$(tput setaf 0)$(tput bold)${git_branch}$(tput sgr0) "
    else
      git_branch="$(tput setaf 2)$(tput bold)${git_branch}$(tput sgr0) "
    fi
  fi

  export PS1="${git_branch}${venv}${pushed_dirs}$(_ps1_str \\W 4)"
}

export PROMPT_COMMAND=_ps1
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

[ -d /usr/local/heroku ] && export PATH="/usr/local/heroku/bin:${PATH}"
[ -e "${HOME}/.meteor" ] && export PATH="${HOME}/.meteor:${PATH}"

export PATH="${HOME}/.local/bin:${HOME}/.local/libexec/git:${PATH}"

[[ -n $HOMEBREW ]] && export MANPATH="$($HOMEBREW/bin/brew --prefix erlang)/lib/erlang/man:${MANPATH}"

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

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true
export ANSIBLE_NOCOWS=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1

[ -r "${DOTBASH}/plat/${OS}/environment.sh" ] && source "${DOTBASH}/plat/${OS}/environment.sh"
[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"
