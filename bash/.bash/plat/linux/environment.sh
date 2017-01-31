export GUI_EDITOR='gvim'

if [ -z "$TMUX" ]; then
  export TERM='xterm-256color'
fi

unset HOMEBREW_EDITOR
