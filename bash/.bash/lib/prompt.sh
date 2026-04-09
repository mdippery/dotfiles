function _ps1_sigil {
  echo -ne "\[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\]"
}

function _ps1_cwd {
  echo -ne "\[$(tput setaf 4)\]\w\[$(tput sgr0)\]"
}

function _ps1_prev_dir {
  if [[ -n "$OLDPWD" ]]; then
    echo -ne "\[$(tput setaf 0)$(tput bold)\] ↪︎ $(basename ${OLDPWD/#$HOME/\~}) \[$(tput sgr0)\]"
  fi
}

function _ps1_exit_code {
  local last_exit=$1
  if (( $last_exit == 0 )); then
    echo -ne "\[$(tput setaf 2)$(tput bold)\]•\[$(tput sgr0)\] "
  else
    echo -ne "\[$(tput setaf 1)$(tput bold)\]•\[$(tput sgr0)\] "
  fi
}

function _ps1_pushed_dirs {
  if (( $(dirs -v | wc -l) > 1 )); then
    echo -ne "\[$(tput setaf 1)\]⎌\[$(tput sgr0)\] "
  fi
}

function _ps1_ssh_host {
  if [ -n "$SSH_TTY" ]; then
    echo -ne "\[$(tput setaf 0)$(tput bold)\]\h\[$(tput sgr0)\] \[$(tput setaf 3)$(tput bold)\]⚡\[$(tput sgr0)\] "
  fi
}

function _ps1_virtual_env {
  local venv
  venv=''
  if [ -n "$VIRTUAL_ENV" ]; then
    if [ $(basename $VIRTUAL_ENV) != '.bundle' ]; then
      venv="$(basename $VIRTUAL_ENV) "
    fi
    echo -ne "\[$(tput setaf 6)\]🐍 ${venv}\[$(tput sgr0)\]"
  fi
}

function _ps1_time {
  echo -ne "\[$(tput setaf 0)$(tput bold)\]\A\[$(tput sgr0)\]"
}

function _ps1_git_branch {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = "true" ]]; then
    echo -ne "\[$(tput setaf 3)\ue0a0 $(git branch --show-current)$(tput sgr0)\]"
  fi
}

function _ps1 {
  export PS1="$(_ps1_ssh_host)$(_ps1_virtual_env)$(_ps1_pushed_dirs)$(_ps1_cwd)$(_ps1_prev_dir)$(_ps1_git_branch)\n$(_ps1_sigil) "
}

# vim: set ft=bash :
