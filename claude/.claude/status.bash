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

# Project directory and Git branch
echo -n "📂 $cwd"
echo -n "$sep"
echo -n "${yellow} $branch${reset}"

# Quota and model
if [ $(tput cols) -gt 100 ]; then echo -n "$sep"; else echo; fi
echo -n "🤖 ${teal}${model}${reset}"
# echo -n "$sep"
# echo -n "⏱️ ${blue}${usage}%${reset}"
