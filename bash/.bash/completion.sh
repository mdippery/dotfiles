brew_completion="$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
[ -r $brew_completion ] && source $brew_completion

bash_completion_d="${DOTBASH}/completions"
for f in $(find -H $bash_completion_d -mindepth 1); do
  source $f
done

bash_completion_d="${DOTBASH}/host/${DOTBASH_HOSTNAME_HASH}/completions"
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

unset brew_completion
unset bash_completion_d

[ -r "${DOTBASH}/completion.user.sh" ] && source "${DOTBASH}/completion.user.sh"
