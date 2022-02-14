# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>

shopt -s globstar

source "${DOTBASH}/lib/prompt.sh"
export PROMPT_COMMAND=_ps1
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

[ -d /opt/homebrew/bin ] && export PATH="/opt/homebrew/bin:${PATH}"
export PATH="${XDG_BIN_HOME}:$(dirname $XDG_BIN_HOME)/libexec/git:${PATH}"
[ -d /Library/TeX/texbin ] && export PATH="${PATH}:/Library/TeX/texbin"
[ -d /opt/X11/bin ] && export PATH="${PATH}:/opt/X11/bin"
brew --prefix gnu-which >/dev/null 2>&1 && export PATH="${PATH}:$(brew --prefix gnu-which)/libexec/gnubin"
brew --prefix gettext >/dev/null 2>&1 && export PATH="${PATH}:$(brew --prefix gettext)/bin"

export EDITOR=vim
export GUI_EDITOR=mvim
export HOMEBREW_EDITOR=$GUI_EDITOR

export PAGER=/usr/bin/less
export LESS=R

export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_EMOJI=1

export ANSIBLE_NOCOWS=1
export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export CUCUMBER_PUBLISH_QUIET=true
export DJANGO_DEBUG=true
export FIGNORE='.terraform:.DS_Store'
export GPG_TTY=$(tty)
export GREP_OPTIONS='--color'
export LESSOPEN="|${XDG_BIN_HOME}/lessopen %s"
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export PIPENV_VENV_IN_PROJECT=true
export TOX_WORKDIR_CACHE="${XDG_CACHE_HOME}/tox"
export TF_PLUGIN_CACHE_DIR="${XDG_CONFIG_HOME}/terraform/plugins"
export GHCUP_USE_XDG_DIRS=true

[ -x /usr/libexec/java_home ] && \
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

hash brew 2>/dev/null && export BREW_PREFIX=$(brew --prefix)

[ -r "${DOTBASH_OS}/environment.sh" ] && source "${DOTBASH_OS}/environment.sh"
[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"

# vim: set ft=bash :
