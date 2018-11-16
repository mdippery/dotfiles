brew_completion=(
  Library/Contributions/brew_bash_completion.sh
  Homebrew/completions/bash/brew
)
for brew in ${brew_completion[@]}; do
  brew="$(brew --prefix)/$brew"
  [ -r $brew ] && source $brew
done

bash_completion_d="$(dotbash)/completions"
for f in $(find -H $bash_completion_d -mindepth 1); do
  source $f
done

bash_completion_d="$(dotbash sys)/completions"
if [ -d $bash_completion_d ]; then
  for f in $(find -H $bash_completion_d -mindepth 1); do
    source $f
  done
fi

bash_completion_d="$(brew --prefix)/etc/bash_completion.d"
if [ -d $bash_completion_d ]; then
  for f in $(find $bash_completion_d -mindepth 1); do
    # Skip git-prompt.sh -- I don't want to source that
    if [ $(basename $f) != 'git-prompt.sh' ]; then
      source $f
    fi
  done
fi

unset brew
unset brew_completion
unset bash_completion_d

[ -r "$(dotbash)/completion.user.sh" ] && source "$(dotbash)/completion.user.sh"
