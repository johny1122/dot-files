#!/bin/bash
# Claude Code statusline: cwd (folder name), model, reasoning effort, git branch

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir=$(basename "$cwd")
model=$(echo "$input" | jq -r '.model.display_name')
effort=$(echo "$input" | jq -r '.effort.level // empty')
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

DIM=$'\033[2m'
RESET=$'\033[0m'
CYAN=$'\033[36m'
MAGENTA=$'\033[35m'
YELLOW=$'\033[33m'
GREEN=$'\033[32m'
BLUE=$'\033[34m'
SEP="${DIM} | ${RESET}"

out="${CYAN}${dir}${RESET}${SEP}${MAGENTA}${model}${RESET}"
[ -n "$effort" ] && out="${out}${SEP}${YELLOW}effort:${effort}${RESET}"
[ -n "$branch" ] && out="${out}${SEP}${GREEN}${branch}${RESET}"
[ -n "$ctx_used" ] && out="${out}${SEP}${BLUE}ctx:$(printf '%.0f' "$ctx_used")%${RESET}"

printf "%s\n" "$out"
