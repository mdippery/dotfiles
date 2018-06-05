function _ps1_str {
  local s=$1
  local color=$2
  echo -ne "\[$(tput setaf $color)\]$s\[$(tput sgr0)\] \[$(tput setaf 0)$(tput bold)\]>\[$(tput sgr0)\] "
}

function _ps1 {
  local last_exit=$?

  local pushed_dirs git_branch venv exit_code

  if (( $(dirs -v | wc -l) > 1 )); then
    pushed_dirs="\[$(tput setaf 1)\]+\[$(tput sgr0)\] "
  fi

  if [ -n "$VIRTUAL_ENV" ]; then
    venv="\[$(tput setaf 6)\]\342\226\266\[$(tput sgr0)\] "
  fi

  if git rev-parse --git-dir >/dev/null 2>&1; then
    git_branch='↯'
    # TODO: Detect untracked files
    if git diff-index --quiet HEAD; then
      git_branch="\[$(tput setaf 0)$(tput bold)\]${git_branch}\[$(tput sgr0)\] "
    else
      git_branch="\[$(tput setaf 2)\]${git_branch}\[$(tput sgr0)\] "
    fi
  fi

  if (( $last_exit == 0 )); then
    exit_code="\[$(tput setaf 2)$(tput bold)\]•\[$(tput sgr0)\] "
  else
    exit_code="\[$(tput setaf 1)$(tput bold)\]•\[$(tput sgr0)\] "
  fi

  export PS1="${exit_code}${pushed_dirs}${venv}${git_branch}$(_ps1_str \\W 4)"
}
