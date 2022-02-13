brew_completion=(
  Library/Contributions/brew_bash_completion.sh
  Homebrew/completions/bash/brew
  completions/bash/brew
)
for brew in ${brew_completion[@]}; do
  brew="${BREW_PREFIX}/$brew"
  [ -r $brew ] && source $brew
done

bash_completion_d="$(dotbash)/completions"
for f in $(find -H $bash_completion_d -mindepth 1 -not -name .gitignore); do
  source $f
done

bash_completion_d="$(dotbash sys)/completions"
if [ -d $bash_completion_d ]; then
  for f in $(find -H $bash_completion_d -mindepth 1 -not -name .gitignore); do
    source $f
  done
fi

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

unset brew
unset brew_completion
unset bash_completion_d
unset d
unset f

[ -r "$(dotbash)/completion.user.sh" ] && source "$(dotbash)/completion.user.sh"
