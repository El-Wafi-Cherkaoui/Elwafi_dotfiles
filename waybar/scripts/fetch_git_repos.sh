#!/bin/bash

REPO_DIR="$HOME/git_repo"

notify-send "Fetching started" "Checking for updates ..."

for dir in "$REPO_DIR"/*/; do
  if [ -d "$dir/.git" ]; then
    cd "$dir" || continue
    repo_name=$(basename "$dir")

    notify-send -n "[$repo_name] "

    # Fetch remote changes silently
    git fetch > /dev/null 2>&1

    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u} 2>/dev/null)
    BASE=$(git merge-base @ @{u} 2>/dev/null)

    if [[ "$LOCAL" = "$REMOTE" ]]; then
      notify-send "$repo_name" "✓ Up to date"
    elif [[ "$LOCAL" = "$BASE" ]]; then
      notify-send "$repo_name" "↑ Needs pull"
    elif [[ "$REMOTE" = "$BASE" ]]; then
      notify-send "$repo_name" "↓ Needs push"
    else
      notify-send "$repo_name" "⇅ Diverged"
    fi
  fi
done


notify-send "Fetching finished"
