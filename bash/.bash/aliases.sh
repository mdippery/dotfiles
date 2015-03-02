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
alias pypath='python -c "import sys; print(\"\\n\".join(sys.path))" | sed "s/^$/\./g"'
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

if hash jq 2>/dev/null; then
  alias json="jq '.'"
else
  alias json='python -mjson.tool'
fi

if [ $OS = 'linux' ]; then
  alias ls='ls -F --color'
  alias mvim='gvim'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboad -o'
fi

[ -r "${BASH}/aliases.user.sh" ] && source "${BASH}/aliases.user.sh"
