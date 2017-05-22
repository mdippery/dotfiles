# Simplifies interaction with dotfiles

function _dots_directory {
  case "$1" in
    dots) echo $DOTFILES ;;
    vims) echo $VIMFILES ;;

    *)
      onoe "No dots directory: $1"
      return 1
  esac
}

function dots_exec {
  local dots_dir git_dir
  dots_dir=$(_dots_directory $1)
  git_dir=$dots_dir/.git
  shift
  case "$1" in
    ln)
      shift
      stow -d $dots_dir $*
      ;;
    rm)
      shift
      stow -D -d $dots_dir $*
      ;;
    up)
      git --git-dir=$git_dir --work-tree=$dots_dir pull
      ;;
    *)
      git --git-dir=$git_dir --work-tree=$dots_dir $*
      ;;
  esac
}

alias dots='dots_exec dots'
alias vims='dots_exec vims'
