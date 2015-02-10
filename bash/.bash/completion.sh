brew_completion="$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
[ -r $brew_completion ] && source $brew_completion
hash pip 2>/dev/null && eval $(pip completion --bash)

bash_completion_d="${HOME}/.bash_completion.d"
for f in $(find -H $bash_completion_d -mindepth 1); do
  source $f
done

bash_completion_d="$(brew --prefix)/etc/bash_completion.d"
for f in $(find $bash_completion_d -mindepth 1); do
  # Skip git-prompt.sh -- I don't want to source that
  if [ $(basename $f) != 'git-prompt.sh' ]; then
    source $f
  fi
done

compleat_script="${HOME}/.cabal/share/$(cabal-platform)/compleat-1.0/compleat_setup"
[ -r $compleat_script ] && source $compleat_script

[ -r "${BASH}/completion.user.sh" ] && source "${BASH}/completion.user.sh"
