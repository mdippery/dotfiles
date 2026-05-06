alias ls='ls -F --color'
alias mvim='gvim'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias rpmbuild='rpmbuild -v -bb --clean'

alias pbc='pbcopy'
alias pbp='pbpaste'

command -v gitk &>/dev/null && alias gitx='gitk'

unalias top
