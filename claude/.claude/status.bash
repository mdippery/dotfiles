#!/bin/bash

input=$(cat)

yellow=$(tput setaf 3)
blue=$(tput setaf 4)
teal=$(tput setaf 6)
reset=$(tput sgr0)

sep=" • "

cwd=$(basename $(echo "$input" | jq -r .workspace.current_dir))
model=$(echo "$input" | jq -r .model.display_name)
usage=$(echo "$input" | jq -r .rate_limits.five_hour.used_percentage)
branch=$(git branch --show-current)

echo -n "📂 $cwd"
echo -n "$sep"
echo -n "${yellow} $branch${reset}"
if [ $(tput cols) -gt 100 ]; then echo -n "$sep"; else echo; fi
# echo -n "⏱️ ${blue}${usage}%${reset}"
# echo -n "$sep"
echo -n "🤖 ${teal}${model}${reset}"
