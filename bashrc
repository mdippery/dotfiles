# TODO: Eventually figure out which of this stuff should go in
# ~/.bash_profile, and which should stay here.


########  SHELL SETUP  ######################################################

export HISTCONTROL=ignoredups
unalias -a                      # I don't want any pre-set aliases


########  ENVIRONMENT CONFIG  ###############################################

NONE='\[\e[0m\]'    # Reset
K='\[\e[0;30m\]'    # Black
R='\[\e[0;31m\]'    # Red
G='\[\e[0;32m\]'    # Green
Y='\[\e[0;33m\]'    # Yellow
B='\[\e[0;34m\]'    # Blue
M='\[\e[0;35m\]'    # Magenta
C='\[\e[0;36m\]'    # Cyan
W='\[\e[0;37m\]'    # White
INV='\[\e[7m\]'     # Invert
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
export PS1="${INVB} \W ${B}${NONE} "

BREW=`brew --prefix`
export PATH="${HOME}/.rbenv/bin:${HOME}/.local/bin:${HOME}/.go/bin:${BREW}/share/npm/bin:${PATH}"

export EDITOR='vim'
export HOMEBREW_EDITOR='mate -r'
export PAGER='/usr/bin/less'
export LESS='R'
#export LESSEDIT='mate -l %lm %f'
#export TEXEDIT='mate -w -l %d "%s"'

#export NODE_PATH=`brew --prefix`/lib/node_modules

export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export PERLBREW_ROOT="${HOME}/.perl5"

export CLICOLOR_FORCE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true    # Don't tar resource forks
export NETHACKOPTIONS=''                        # MacBook doesn't have a numberpad
export DJANGO_DEBUG=true

export NYRB_VM_SHARED='../../vagrant'


########  ALIASES  ##########################################################

alias be='bundle exec'
alias bi='bundle install --path=.bundle'
alias brm='rm -rf .bundle && bi'
alias df='df -h'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias du='du -sh'
alias egrep='egrep --color'
alias epath='echo $PATH | tr ":" "\n"'
alias fgrep='fgrep --color'
#alias fortune='fortune -a'
alias fs='foreman start'
alias fsd='foreman start -f Procfile.dev'
alias gems='gem list | cut -d" " -f1'
alias grep='grep --color'
alias h='history'
alias hero='heroku'
#alias hf='history | /usr/bin/grep --color'
alias hide='SetFile -a V'
alias i='dirs -v'
alias ip='curl ifconfig.me'
alias javap='javap -classpath build'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias json='python -mjson.tool'
alias ll='ls -lh'
alias ls='ls -FG'
#alias locate='mdfind -name'
#alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump'
alias mate='mate -r'
alias mongod="mongod -f $(brew --prefix)/etc/mongod.conf"
alias myip='curl http://icanhazip.com/'
alias o='popd'
alias openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
alias p='pushd'
alias pyclean="find . -name '*.pyc' | xargs rm -f"
alias rb='rbenv'
alias rh='runhaskell'
alias rm='rm -i'
#alias rwhich='resolve-which'
alias rspec='rspec --color'
#alias svnauthors="svn log --xml | grep author | sort -u | perl -pe 's/.>(.?)<./$1 = /'"
alias t='type'
alias top='top -o cpu'
alias uuid='/usr/bin/uuidgen'
alias ve='virtualenv'
alias which='(alias ; declare -f) | /usr/local/bin/which --tty-only --read-alias --read-functions --show-dot --show-tilde'
#alias work='cd ~/Projects/neonmob/apps/neonmob'


########  FUNCTIONS  ########################################################

function char { echo -n "$1" | hexdump -C; }

function exe {
  touch $1
  mate -r $1
}

function xexe {
  touch $1
  chmod +x $1
  mate -r $1
}

# Returns the HTTP status code for a URL
function hstat { curl -I $1 2>/dev/null | head -1; }

# Opens a man page in Preview
function pman { man -t $1 | open -f -a /Applications/Preview.app; }

# Does a reverse DNS lookup on an IP
function rvdns { nslookup $1 | awk '/name = .*\.$/ {print $4}' | sed 's/\.$//'; }

function vv {
  if [ ! -d .venv ]; then
    echo "No virtualenv in ${PWD}"
    return 1
  fi
  venv=$(/bin/ls -1 .venv)
  #source ".venv/${venv}/bin/activate"
  vpath=$(cd .venv/$venv && pwd)
  export PATH="${vpath}/bin:${PATH}"
  export PS1="${DW}${venv}${NONE} ${PS1}"
}


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
export SCALA_HOME="${HOME}/.scalabrew/scalas/Current"
export PATH="${SCALA_HOME}/bin:${PATH}"

source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
source `brew --prefix`/etc/bash_completion.d/git-completion.bash
source ~/.bash_completion.d/django_bash_completion
eval $(pip completion --bash)
