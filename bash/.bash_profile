if hash fortune 2>/dev/null && hash cowsay 2>/dev/null; then
  fortune | cowsay -n | cut -c-$(tput cols)
fi

[ -r ~/.bashrc ] && source ~/.bashrc
