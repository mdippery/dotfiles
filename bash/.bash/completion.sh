brew_completion=(
  Library/Contributions/brew_bash_completion.sh
  Homebrew/completions/bash/brew
  completions/bash/brew
)
for brew in ${brew_completion[@]}; do
  brew="${BREW_PREFIX}/$brew"
  [ -r $brew ] && source $brew
done

bash_completion_d="${DOTBASH}/completions"
for f in $(find -H $bash_completion_d -mindepth 1 -not -name .gitignore); do
  source $f
done

bash_completion_d=(bash_completion profile)
for d in ${bash_completion_d[@]}; do
  d="${BREW_PREFIX}/etc/${d}.d"
  if [ -d $d ]; then
    for f in $(find $d -mindepth 1 -not -name .gitignore); do
      # Skip git-prompt.sh -- I don't want to source that
      if [ $(basename $f) != 'git-prompt.sh' ]; then
        source $f
      fi
    done
  fi
done

hash stack 2>/dev/null && eval "$(stack --bash-completion-script stack)"

hash aws_completer 2>/dev/null && complete -C aws_completer aws

unset brew
unset brew_completion
unset bash_completion_d
unset d
unset f

[ -r "${DOTBASH}/completion.user.sh" ] && source "${DOTBASH}/completion.user.sh"
