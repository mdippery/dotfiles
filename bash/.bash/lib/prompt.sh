[ -r "$(dotbash)/lib/prompt.user.sh" ] && source "$(dotbash)/lib/prompt.user.sh"

function _ps1_str {
  local s=$1
  local color=$2
  echo -ne "\[$(tput setaf $color)\]$s\[$(tput sgr0)\] \[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\] "
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

function _ps1_virtual_env {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo -ne "\[$(tput setaf 6)\]▶[$(tput sgr0)\] "
  fi
}

function _ps1 {
  local last_exit=$?
  local custom_ps1
  if type -t _ps1_custom >/dev/null 2>&1; then
    custom_ps1=$(_ps1_custom)
  fi
  export PS1="$(_ps1_exit_code $last_exit)${custom_ps1}$(_ps1_pushed_dirs)$(_ps1_virtual_env)$(_ps1_git_prompt)$(_ps1_str \\W 4)"
}
