########  SHELL SETUP  ######################################################

export HISTCONTROL=ignoredups
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases

# Parts of this script rely on `brew`, which is only installed
# on my Macs. Instead of wrapping a lot of the logic in conditionals
# that check for the presence of `brew`, provide a fake one if it is
# not installed.
if ! hash brew 2>/dev/null; then
  function brew {
    if [ ! -z "$OPT" ]; then
      echo "$OPT"
    else
      echo "/usr/local"
    fi
  }
fi


########  ENVIRONMENT CONFIG  ###############################################

export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
if [ $OS = 'linux' ]; then
  export USER_ENV='ilm'
fi

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

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true
export ANSIBLE_NOCOWS=1
export HOMEBREW_NO_EMOJI=1

if [ $OS = 'linux' ]; then
  export GUI_EDITOR='/usr/bin/gvim'
  unset HOMEBREW_EDITOR
fi

if [ "$USER_ENV" = 'ilm' ]; then
  PATH="/usr/local/sbin:/usr/sbin:/sbin"
  PATH="/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:${PATH}"
  PATH="/sww/gfx/bin:/sww/tools/bin:/sww/sand/bin:/dept/is/prodsoft/bin:${PATH}"
  PATH="${OPT}/bin:${PATH}"
  export PATH
fi


########  ALIASES  ##########################################################

alias be='bundle exec'
alias bi='bundle install --path=.bundle'
alias brm='rm -rf .bundle && bi'
alias clj='lein repl'
alias ctags='ctags -f .tags'
alias d='pwd'
alias df='df -h'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias du='du -sh'
alias egrep='egrep --color'
alias ffs='sudo $(history -p \!\!)'
alias fgrep='fgrep --color'
alias fs='foreman start'
alias fsd='foreman start -f Procfile.dev'
alias gems='gem list | cut -d" " -f1'
alias grep='grep --color'
alias h='history'
alias hide='SetFile -a V'
alias i='dirs -v'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias javap='javap -classpath build'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias json='python -mjson.tool'
alias ll='ls -lh'
alias ls='ls -FG'
#alias locate='mdfind -name'
#alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump'
alias mate='mate -r'
alias md='open -a /Applications/Byword.app'
alias mongod="mongod -f $(brew --prefix)/etc/mongod.conf"
alias o='popd'
alias openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
alias p='pushd'
alias path='echo $PATH | tr ":" "\n"'
alias pyclean="find . -name '*.pyc' | xargs rm -f"
alias res="osascript -e 'tell application \"Finder\" to get bounds of window of desktop' | cut -d, -f 3,4 | sed 's/, /x/' | tr -d ' '"
alias rh='runhaskell'
alias rm='rm -i'
alias ssh-reset="printf '\e]0;\a'"
alias t='type'
alias top='top -o cpu'
alias uuid='/usr/bin/uuidgen'
alias ve='virtualenv --always-copy'
alias vimsyn="/bin/ls /usr/share/vim/vim$(vim --version | head -n 1 | egrep --color=never -o '(7\.[0-9])' | tr -d '.')/syntax/*.vim | cut -d '/' -f 7"
alias which="(alias ; declare -f) | $(brew --prefix)/bin/which --tty-only --read-alias --read-functions --show-dot --show-tilde"

if [ $OS = 'linux' ]; then
  alias ls='ls -F --color'
  alias mvim='gvim'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboad -o'
fi


########  FUNCTIONS  ########################################################

function abspath { cd $1 && pwd -P; }

function char { echo -n "$1" | hexdump -C; }

function erlp {
  local proj=$1
  mkdir $proj
  mkdir $proj/{ebin,include,priv,src}
  cat > $proj/Emakefile <<EOF
{'src/*', [debug_info,
           {i, "src"},
           {i, "include"},
           {outdir, "ebin"}]}.
EOF
}

function exe {
  touch $1
  $GUI_EDITOR $1
}

function xexe {
  touch $1
  chmod +x $1
  $GUI_EDITOR $1
}

function get-pip { wget https://bootstrap.pypa.io/get-pip.py; }

# Returns the HTTP status code for a URL
function hstat { curl -I $1 2>/dev/null | head -1; }

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

# Does a reverse DNS lookup on an IP
function rvdns { nslookup $1 | awk '/name = .*\.$/ {print $4}' | sed 's/\.$//'; }

function uuid7 {
    u=$(date | md5sum)
    echo "${u:0:7}"
}

function vv {
  if [ ! -d .venv ]; then
    echo "No virtualenv in ${PWD}"
    return 1
  fi
  venv=$(/bin/ls -1 .venv)
  vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  export PS1="\[$(tput setaf 3)\]\$\[$(tput sgr0)\] "
}

function whois { /usr/bin/whois $1 | $PAGER; }


########  ENVIRONMENT  ######################################################

if [ -d ~/.rubies ]; then
  source "${HOME}/.local/share/chruby/chruby.sh"
  chruby $(/bin/ls ~/.rubies | tail -n 1)
fi

if [ -d ~/.pythons ]; then
  py_home=$(echo $(abspath ~/.pythons/Current))
  py_vers=$(basename $py_home)
  py_fam=${py_vers:0:1}
  export PATH="${py_home}/bin:${PATH}"
  export ANSIBLE_LIBRARY="${py_home}/share/ansible"
  export TOX_PYTHONS="${HOME}/.pythons"

  if [ ${py_fam} = '3' ]; then
    alias pip='pip3'
    alias python='python3'
    alias ve='pyvenv'
  fi
fi

if [ -d ~/.scalas ]; then
  export SCALA_HOME=$(abspath ~/.scalas/Current)
  export PATH="${SCALA_HOME}/bin:${PATH}"
fi

brew_completion="$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
[ -r $brew_completion ] && source $brew_completion
hash pip 2>/dev/null && eval $(pip completion --bash)

bash_completion_d="${HOME}/.bash_completion.d"
for f in $(find -H $bash_completion_d -mindepth 1); do
  source $f
done

bash_completion_d="$(brew --prefix)/etc/bash_completion.d"
for f in $(find $bash_completion_d -mindepth 1); do
  # Skip git-prompt.sh -- I don't want to source that
  if [ $(basename $f) != 'git-prompt.sh' ]; then
    source $f
  fi
done

compleat_script="$(brew --prefix)/opt/compleat/share/x86_64-osx-ghc-7.8.3/compleat-1.0/compleat_setup"
if [ -r $compleat_script ]; then
  source $compleat_script
else
  compleat_script="$(brew --prefix)/opt/compleat/share/compleat-1.0/compleat_setup"
  [ -r $compleat_script ] && source $compleat_script
fi

bashrc_local="${HOME}/.bashrc.user"
[ -r $bashrc_local ] && source $bashrc_local
