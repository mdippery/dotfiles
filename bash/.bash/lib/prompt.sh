function _ps1_sigil {
  echo -ne "\[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\]"
}

function _ps1_cwd {
  echo -ne "\[$(tput setaf 4)\]\w\[$(tput sgr0)\]"
}

function _ps1_git_prompt {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    local git_branch='↯'
    # TODO: Detect untracked files
    if ! git rev-parse HEAD >/dev/null 2>&1 || git diff-index --quiet HEAD; then
      echo -ne "\[$(tput setaf 0)$(tput bold)\]${git_branch}\[$(tput sgr0)\] "
    else
      echo -ne "\[$(tput setaf 2)\]${git_branch}\[$(tput sgr0)\] "
    fi
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
    echo -ne "\[$(tput setaf 1)\]+\[$(tput sgr0)\] "
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
    echo -ne " \[$(tput setaf 3)\ue0a0 $(git branch --show-current)$(tput sgr0)\]"
  fi
}

function _ps1 {
  local last_exit=$?
  local custom_ps1
  if type -t _ps1_custom >/dev/null 2>&1; then
    custom_ps1=$(_ps1_custom)
  fi
  export PS1="$(_ps1_time) $(_ps1_ssh_host)$(_ps1_virtual_env)$(_ps1_pushed_dirs)$(_ps1_cwd)$(_ps1_git_branch)\n$(_ps1_sigil) "
}

# vim: set ft=bash :
