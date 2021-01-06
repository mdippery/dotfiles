alias bc='bundle console'
alias be='bundle exec'
alias bi='bundle install --path=.bundle'
alias clj='lein repl'
alias coin-flip='rand 1 2'
alias ctags='ctags -f .tags'
alias d='pwd'
alias df='df -h'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias du='du -sh'
alias epoch='date +%s'
alias ffs='sudo $(fc -ln -1)'
alias fs='foreman start'
alias gems='gem list | cut -d" " -f1'
alias h='history'
alias hasktags='hasktags -f .tags'
alias hide='SetFile -a V'
alias i='dirs -v'
alias javap='javap -cp build:$(sbt_classes)'
alias ll='ls -lh'
alias ls='ls -FG'
alias mate='mate -r'
alias md='open -a /Applications/Byword.app'
alias mkdir='mkdir -p'
alias mongod="mongod -f ${BREW_PREFIX}/etc/mongod.conf"
alias myip='curl icanhazip.com'
alias nth-line='grab-line'
alias o='popd 2>/dev/null || cd -'
alias p='pushd'
alias path='echo $PATH | tr ":" "\n"'
alias pe='printenv'
alias pyack='ack --type=python'
alias pydoc='python -m pydoc'
alias pytree="tree -I '__pycache__|*.pyc|*.egg-info'"
alias Q='echo $OLDPWD'
alias q='cd -'
alias rh='runhaskell'
alias rm='rm -i'
alias ssh-reset="printf '\e]0;\a'"
alias t='type'
alias ta='tmux attach'
alias tab='column -t'
alias tg='tmux a'
alias top='top -o cpu'
alias vundle='vim +PluginInstall +qall'
alias w='which'
alias weather='curl wttr.in'
alias which="(alias ; declare -f) | ${BREW_PREFIX}/bin/which --tty-only --read-alias --read-functions --show-dot --show-tilde"

hash jq 2>/dev/null && alias json="jq -C '.'" || alias json='python -mjson.tool'
hash uuid 2>/dev/null || alias uuid='/usr/bin/uuidgen'

[ -r "$(dotbash plat)/aliases.sh" ] && source "$(dotbash plat)/aliases.sh"
[ -r "$(dotbash)/aliases.user.sh" ] && source "$(dotbash)/aliases.user.sh"
