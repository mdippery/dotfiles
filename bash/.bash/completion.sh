brew_completion=(
  Library/Contributions/brew_bash_completion.sh
  Homebrew/completions/bash/brew
  completions/bash/brew
)
for brew in ${brew_completion[@]}; do
  brew="${BREW_PREFIX}/$brew"
  [ -r $brew ] && source $brew
done

bash_completion_d=$BASH_COMPLETION_USER_DIR
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

complete -c bcat

command -v stack &>/dev/null && eval "$(stack --bash-completion-script stack)"
command -v just &>/dev/null && eval "$(just --completions=bash)"
command -v ngrok &>/dev/null && eval "$(ngrok completion)"

command -v aws_completer &>/dev/null && complete -C aws_completer aws

unset brew
unset brew_completion
unset bash_completion_d
unset d
unset f

[ -r "${DOTBASH_OS}/completion.sh" ] && source "${DOTBASH_OS}/completion.sh"
[ -r "${DOTBASH}/completion.user.sh" ] && source "${DOTBASH}/completion.user.sh"

# vim: set ft=bash :
