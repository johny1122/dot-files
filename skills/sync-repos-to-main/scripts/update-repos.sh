#!/usr/bin/env bash
# Fast-forward every git repo directly under TARGET_DIR to its default branch (main/master).
# Never merges, rebases, or discards local work — anything that isn't a safe fast-forward
# is reported, not attempted. Prints one result line per repo:
#   OK|<repo>|<message>
#   SKIP|<repo>|<reason>
set -uo pipefail

TARGET_DIR="${1:-.}"

cd "$TARGET_DIR" || { echo "ERROR|-|cannot cd into $TARGET_DIR"; exit 1; }

shopt -s nullglob
for entry in */; do
  name="${entry%/}"
  [ -d "$entry/.git" ] || continue

  (
    cd "$entry" || exit 0

    if ! git remote get-url origin >/dev/null 2>&1; then
      echo "SKIP|$name|no remote 'origin' configured"
      exit 0
    fi

    fetch_err=$(git fetch origin --quiet 2>&1)
    if [ $? -ne 0 ]; then
      echo "SKIP|$name|git fetch failed: $(echo "$fetch_err" | tr '\n' ' ')"
      exit 0
    fi

    if ! git symbolic-ref -q HEAD >/dev/null; then
      echo "SKIP|$name|detached HEAD (not on a branch)"
      exit 0
    fi
    current_branch=$(git symbolic-ref --short HEAD)

    default_branch=""
    for b in main master; do
      if git show-ref --verify --quiet "refs/remotes/origin/$b"; then
        default_branch="$b"
        break
      fi
    done
    if [ -z "$default_branch" ]; then
      echo "SKIP|$name|no origin/main or origin/master branch found"
      exit 0
    fi

    if [ -n "$(git status --porcelain)" ]; then
      echo "SKIP|$name|uncommitted local changes (working tree not clean)"
      exit 0
    fi

    if [ "$current_branch" != "$default_branch" ]; then
      if git show-ref --verify --quiet "refs/heads/$default_branch"; then
        co_err=$(git checkout --quiet "$default_branch" 2>&1)
      else
        co_err=$(git checkout --quiet -b "$default_branch" --track "origin/$default_branch" 2>&1)
      fi
      if [ $? -ne 0 ]; then
        echo "SKIP|$name|failed to switch to $default_branch: $(echo "$co_err" | tr '\n' ' ')"
        exit 0
      fi
    fi

    before=$(git rev-parse HEAD)
    merge_err=$(git merge --ff-only --quiet "origin/$default_branch" 2>&1)
    if [ $? -eq 0 ]; then
      after=$(git rev-parse HEAD)
      if [ "$before" = "$after" ]; then
        echo "OK|$name|already up to date on $default_branch"
      else
        n=$(git rev-list --count "$before..$after")
        echo "OK|$name|updated $default_branch (pulled $n commit(s))"
      fi
    else
      ahead=$(git rev-list --count "origin/$default_branch..$default_branch")
      behind=$(git rev-list --count "$default_branch..origin/$default_branch")
      if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
        echo "SKIP|$name|diverged from origin/$default_branch ($ahead ahead, $behind behind) - fast-forward not possible, manual merge/rebase needed"
      elif [ "$ahead" -gt 0 ]; then
        echo "SKIP|$name|local $default_branch is $ahead commit(s) ahead of origin/$default_branch (unpushed local commits)"
      else
        echo "SKIP|$name|fast-forward failed: $(echo "$merge_err" | tr '\n' ' ')"
      fi
    fi
  )
done
