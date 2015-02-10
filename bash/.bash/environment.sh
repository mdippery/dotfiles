export OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# tput usage can be found here:
#   <http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/>
#   <http://unix.stackexchange.com/a/105932/57970>
export PS1="\[$(tput setaf 4)\]hello :)\[$(tput sgr0)\] "
export PS2="\[$(tput setaf 1)\]\342\200\246\[$(tput sgr0)\]        "

export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:/usr/local/heroku/bin:${PATH}"
export MANPATH="$(brew --prefix erlang)/lib/erlang/man:${MANPATH}"

export EDITOR='/usr/bin/vim'
export GUI_EDITOR='/usr/local/bin/mvim'
export HOMEBREW_EDITOR="$GUI_EDITOR"
export PAGER='/usr/bin/less'
export LESS='R'

export FIGNORE='DS_Store'

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi

export LOCAL="${HOME}/.local"

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true
export ANSIBLE_NOCOWS=1
export HOMEBREW_NO_EMOJI=1

if [ $OS = 'linux' ]; then
  export TERM='xterm-256color'
  export GUI_EDITOR='/usr/bin/gvim'
  unset HOMEBREW_EDITOR
fi

[ -r "${BASH}/environment.user.sh" ] && source "${BASH}/environment.user.sh"
