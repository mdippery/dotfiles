function greet {
  local green grey reset
  green="$(tput setaf 2)"
  grey="$(tput setaf 0)$(tput bold)"
  reset=$(tput sgr0)
  cat <<EOM
🤓    ${green}$(whoami)${reset}${grey}@$(hostname)${reset}
🌽    ${grey}$(uname) $(uname -r)${reset}
🐚    ${grey}${SHELL}${reset}
🗓     ${grey}$(date)${reset}
EOM
}
