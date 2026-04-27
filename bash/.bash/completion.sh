brew_completion=(
  Library/Contributions/brew_bash_completion.sh
  Homebrew/completions/bash/brew
  completions/bash/brew
)
for brew in ${brew_completion[@]}; do
  brew="${BREW_PREFIX}/$brew"
  [ -r $brew ] && source $brew
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

bash_completion_d=$BASH_COMPLETION_USER_DIR
for f in $(find -H $bash_completion_d -mindepth 1 -not -name .gitignore); do
  source $f
done

complete -c bcat
complete -c sym
complete -c whither

command -v aws_completer &>/dev/null && complete -C aws_completer aws

command -v ngrok &>/dev/null && eval "$(ngrok completion)"
command -v stack &>/dev/null && eval "$(stack --bash-completion-script stack)"

# Could also be done for fd in case I install it via Cargo, too, but
# fd takes --gen-completions.
# rg does not offer a way to generate completions from the command line.
if command -v just &>/dev/null && ! grep -q just <(complete -p); then
  eval "$(just --completions=bash)"
fi

unset brew
unset brew_completion
unset bash_completion_d
unset d
unset f

[ -r "${DOTBASH_PLAT}/completion.sh" ] && source "${DOTBASH_PLAT}/completion.sh"
[ -r "${DOTBASH}/completion.user.sh" ] && source "${DOTBASH}/completion.user.sh"

# vim: set ft=bash :
