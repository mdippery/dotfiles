alias bc='bundle console'
alias be='bundle exec'
alias bi='bundle install --path=.bundle'
alias clj='lein repl'
alias ctags='ctags -f .tags'
alias d='pwd'
alias df='df -h'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias du='du -sh'
alias egrep='egrep --color'
alias ffs='sudo $(fc -ln -1)'
alias fgrep='fgrep --color'
alias fs='foreman start'
alias gems='gem list | cut -d" " -f1'
alias grep='grep --color'
alias h='history'
alias hide='SetFile -a V'
alias i='dirs -v'
alias javap='javap -cp build:$(sbt_classes)'
alias ll='ls -lh'
alias ls='ls -FG'
alias mate='mate -r'
alias md='open -a /Applications/Byword.app'
alias mkdir='mkdir -p'
alias mongod="mongod -f $(brew --prefix)/etc/mongod.conf"
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias nth-line='grab-line'
alias o='popd 2>/dev/null || cd -'
alias p='pushd'
alias path='echo $PATH | tr ":" "\n"'
alias pyack='ack --type=python'
alias Q='echo $OLDPWD'
alias q='cd -'
alias rh='runhaskell'
alias rm='rm -i'
alias ssh-reset="printf '\e]0;\a'"
alias t='type'
alias tab='column -t'
alias tg='tmux a'
alias top='top -o cpu'
alias uuid='/usr/bin/uuidgen'
alias vex='vex --path=.bundle'
alias virtualenv='virtualenv --always-copy'
alias vundle='vim +PluginInstall +qall'
alias w='which'
alias which="(alias ; declare -f) | $(brew --prefix)/bin/which --tty-only --read-alias --read-functions --show-dot --show-tilde"

hash jq 2>/dev/null && alias json="jq -C '.'" || alias json='python -mjson.tool'

if [ $OS = 'linux' ]; then
  alias ls='ls -F --color'
  alias mvim='gvim'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'

  hash gitk 2>/dev/null && alias gitx='gitk'

  unalias top
fi

[ -r "${DOTBASH}/aliases.user.sh" ] && source "${DOTBASH}/aliases.user.sh"
