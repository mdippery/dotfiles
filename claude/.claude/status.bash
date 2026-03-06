#!/bin/bash

input=$(cat)

yellow=$(tput setaf 3)
teal=$(tput setaf 6)
reset=$(tput sgr0)

sep=" • "

cwd=$(basename $(echo "$input" | jq -r .workspace.current_dir))
model=$(echo "$input" | jq -r .model.display_name)
branch=$(git branch --show-current)

# echo "📂 $cwd • ${yellow} $branch${reset} • 🤖 ${teal}${model}${reset}"
echo -n "📂 $cwd"
echo -n "$sep"
echo -n "${yellow} $branch${reset}"
if [ $(tput cols) -gt 100 ]; then echo -n "$sep"; else echo; fi
echo -n "🤖 ${teal}${model}${reset}"
