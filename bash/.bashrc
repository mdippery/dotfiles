# TODO: Eventually figure out which of this stuff should go in
# ~/.bash_profile, and which should stay here.


########  SHELL SETUP  ######################################################

export HISTCONTROL=ignoredups
shopt -s histappend

unalias -a                      # I don't want any pre-set aliases


########  ENVIRONMENT CONFIG  ###############################################

# TODO: Use tput set{af,ab} for these values, as shown here:
# <http://unix.stackexchange.com/a/105932/57970>
NONE='\[\e[0m\]'    # Reset
K='\[\e[0;30m\]'    # Black
R='\[\e[0;31m\]'    # Red
G='\[\e[0;32m\]'    # Green
Y='\[\e[0;33m\]'    # Yellow
B='\[\e[0;34m\]'    # Blue
M='\[\e[0;35m\]'    # Magenta
C='\[\e[0;36m\]'    # Cyan
W='\[\e[0;37m\]'    # White
INVB='\[\e[7;34m\]' # Invert blue
EMK='\[\e[1;30m\]'  # Bold Black
EMR='\[\e[1;31m\]'  # Bold Red
EMG='\[\e[1;32m\]'  # Bold Green
EMY='\[\e[1;33m\]'  # Bold Yellow
EMB='\[\e[1;34m\]'  # Bold Blue
EMM='\[\e[1;35m\]'  # Bold Magenta
EMC='\[\e[1;36m\]'  # Bold Cyan
EMW='\[\e[1;37m\]'  # Bold White
DK='\[\e[2;30m\]'   # Dim Black
DR='\[\e[2;31m\]'   # Dim Red
DG='\[\e[2;32m\]'   # Dim Green
DY='\[\e[2;33m\]'   # Dim Yellow
DB='\[\e[2;34m\]'   # Dim Blue
DM='\[\e[2;35m\]'   # Dim Magenta
DC='\[\e[2;36m\]'   # Dim Cyan
DW='\[\e[2;37m\]'   # Dim White
export PS1="${EMM}\$${NONE} "
export PS2="${R}\342\200\246${NONE} "

export PATH="${HOME}/.rbenv/bin:${HOME}/.cabal/bin:${HOME}/.local/bin:/usr/local/heroku/bin:${PATH}"
export MANPATH="$(brew --prefix erlang)/lib/erlang/man:${MANPATH}"

export EDITOR='vim'
export GUI_EDITOR='mvim'
export HOMEBREW_EDITOR="$GUI_EDITOR"
export PAGER='/usr/bin/less'
export LESS='R'
#export LESSEDIT='mate -l %lm %f'
#export TEXEDIT='mate -w -l %d "%s"'

export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true

export NYRB_VM_SHARED="${HOME}/Developer/Projects/Work/nybooks/vagrant"
export NYRB_SEARCH_DOMAIN='192.168.0.10'


########  ALIASES  ##########################################################

alias be='bundle exec'
alias bi='bundle install --path=.bundle'
alias brm='rm -rf .bundle && bi'
alias clj='lein repl'
alias d='pwd'
alias df='df -h'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias du='du -sh'
alias egrep='egrep --color'
alias epath='echo $PATH | tr ":" "\n"'
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
alias mongod="mongod -f $(brew --prefix)/etc/mongod.conf"
alias o='popd'
alias openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
alias p='pushd'
alias pyclean="find . -name '*.pyc' | xargs rm -f"
alias rb='rbenv'
alias res="osascript -e 'tell application \"Finder\" to get bounds of window of desktop' | cut -d, -f 3,4 | sed 's/, /x/' | tr -d ' '"
alias rh='runhaskell'
alias rm='rm -i'
alias ssh-reset="printf '\e]0;\a'"
alias t='type'
alias top='top -o cpu'
alias uuid='/usr/bin/uuidgen'
alias ve='virtualenv'
alias vimsyn="/bin/ls /usr/share/vim/vim73/syntax/*.vim | cut -d '/' -f 7"
alias which='(alias ; declare -f) | /usr/local/bin/which --tty-only --read-alias --read-functions --show-dot --show-tilde'


########  FUNCTIONS  ########################################################

function char { echo -n "$1" | hexdump -C; }

function exe {
  touch $1
  $GUI_EDITOR $1
}

function xexe {
  touch $1
  chmod +x $1
  $GUI_EDITOR $1
}

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
  #source ".venv/${venv}/bin/activate"
  vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  export PS1="${Y}\$${NONE} "
}

function whois { /usr/bin/whois $1 | $PAGER; }


########  ENVIRONMENT  ######################################################

eval "$(rbenv init -)"

if [ -d ~/.pythonbrew ]; then
  alias pbr='pythonbrew'
  source ~/.pythonbrew/etc/bashrc
elif [ -d ~/.pyenv ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
fi

# TODO: Create a set of scripts to do this, like above
if [ -d "${HOME}/.scalas" ]; then
  export SCALA_HOME="${HOME}/.scalas/scalas/Current"
  export PATH="${SCALA_HOME}/bin:${PATH}"
fi

source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
source `brew --prefix`/etc/bash_completion.d/git-completion.bash
source ~/.bash_completion.d/django_bash_completion
eval $(pip completion --bash)

npm_complete="$(brew --prefix)/etc/bash_completion.d/npm"
[ -r $npm_complete ] && source $npm_complete
unset npm_complete

compleat_script="$(brew --prefix)/opt/compleat/share/compleat-1.0/compleat_setup"
[ -r $compleat_script ] && source $compleat_script
unset compleat_script

bashrc_local="${HOME}/.bash_local/bashrc"
[ -r $bashrc_local ] && source $bashrc_local
unset bashrc_local
