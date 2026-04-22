# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>

shopt -s globstar

source "${DOTBASH}/lib/prompt.sh"
PROMPT_COMMAND=_ps1
command -v update_terminal_cwd &>/dev/null && PROMPT_COMMAND="${PROMPT_COMMAND}; update_terminal_cwd"
export PROMPT_COMMAND
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\] "
export PROMPT_DIRTRIM=3

export DOTFILES="${HOME}/.dotfiles"
export VIMFILES="${HOME}/.vimfiles"

export PATH=$(paths-helper)

export EDITOR=vim
export GUI_EDITOR=mvim
export HOMEBREW_EDITOR=$GUI_EDITOR

export PAGER=/usr/bin/less
export LESS=R

export BREW_PREFIX=$(brew --prefix)
export BREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_EMOJI=1

export ANSIBLE_NOCOWS=1
export BASH_COMPLETION_USER_DIR="${DOTBASH}/completions"
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1
export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export CUCUMBER_PUBLISH_QUIET=true
export DJANGO_DEBUG=true
export FIGNORE='.terraform:.DS_Store:.localized'
export GHCUP_USE_XDG_DIRS=true
export GOPATH="${HOME}/Library/Application Support/go"
export GPG_TTY=$(tty)
export GREP_OPTIONS='--color'
export LESSOPEN="|${XDG_BIN_HOME}/lessopen %s"
export MORIA=-r
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export PIPENV_VENV_IN_PROJECT=true
export PYTHONDONTWRITEBYTECODE=1
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
export TOX_WORKDIR_CACHE="${XDG_CACHE_HOME}/tox"
export TF_PLUGIN_CACHE_DIR="${XDG_CACHE_HOME}/terraform/plugins"
export UV_PROJECT_ENVIRONMENT=.bundle
export XML_CATALOG_FILES="$(brew --prefix)/etc/xml/catalog"

export PSQL_HISTORY="${XDG_STATE_HOME}/psql/history"
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history.py3"

[ -x /usr/libexec/java_home ] && \
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

mkdir -p "$TF_PLUGIN_CACHE_DIR"
mkdir -p $(dirname "$PSQL_HISTORY")
mkdir -p $(dirname "$PYTHON_HISTORY")
mkdir -p "$XDG_STATE_HOME/ruby"

[ -r "${DOTBASH_OS}/environment.sh" ] && source "${DOTBASH_OS}/environment.sh"
[ -r "${DOTBASH}/environment.user.sh" ] && source "${DOTBASH}/environment.user.sh"

# vim: set ft=bash :
