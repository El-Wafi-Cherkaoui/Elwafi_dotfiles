#!/bin/bash

REPO_DIR="$HOME/git_repo"

echo "Checking for updates in repos under $REPO_DIR..."

for dir in "$REPO_DIR"/*/; do
  if [ -d "$dir/.git" ]; then
    cd "$dir" || continue
    repo_name=$(basename "$dir")

    echo -n "[$repo_name] "

    # Fetch remote changes silently
    git fetch > /dev/null 2>&1

    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u} 2>/dev/null)
    BASE=$(git merge-base @ @{u} 2>/dev/null)

    if [[ "$LOCAL" = "$REMOTE" ]]; then
      echo "✓ Up to date"
    elif [[ "$LOCAL" = "$BASE" ]]; then
      echo "↑ Needs pull"
    elif [[ "$REMOTE" = "$BASE" ]]; then
      echo "↓ Needs push"
    else
      echo "⇅ Diverged"
    fi
  fi
done


echo "Repo"
