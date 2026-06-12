#!/bin/bash

input=$(cat)

yellow=$(tput setaf 3)
blue=$(tput setaf 4)
teal=$(tput setaf 6)
reset=$(tput sgr0)

sep=" • "

# cwd=$(basename $(jq -r .workspace.current_dir <<<"$input"))
project_dir=$(basename $(jq -r .workspace.project_dir <<<"$input"))
model=$(jq -r .model.display_name <<<"$input")
usage=$(jq -r .rate_limits.five_hour.used_percentage <<<"$input")
cost=$(printf "$%.2f" $(jq -r .cost.total_cost_usd <<<"$input"))
branch=$(git branch --show-current)

# Project directory and Git branch
echo -n "📂 $project_dir"
echo -n "$sep"
echo -n "${yellow} $branch${reset}"

# Quota and model
if [ $(tput cols) -gt 100 ]; then echo -n "$sep"; else echo; fi
echo -n "🤖 ${teal}${model}${reset}"
echo -n "$sep"
echo -n "💸 ${cost}"
# echo -n "$sep"
# echo -n "⏱️ ${blue}${usage}%${reset}"
