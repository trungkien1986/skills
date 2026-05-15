#!/usr/bin/env bash
# Check for upstream skill updates since last sync.
# Usage: bash scripts/check-upstream-updates.sh

set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SYNC_FILE="$SKILLS_DIR/.skill-sync"

# Ensure we have upstream remote
if ! git -C "$SKILLS_DIR" remote | grep -q upstream; then
  echo "Error: No 'upstream' remote configured."
  echo "Run: git remote add upstream https://github.com/mattpocock/skills.git"
  exit 1
fi

git -C "$SKILLS_DIR" fetch upstream 2>/dev/null

# Determine last sync point
if [ -f "$SYNC_FILE" ]; then
  LAST_SYNC=$(grep -v '^#' "$SYNC_FILE" | head -1)
  # Validate the hash exists in the repo
  if git -C "$SKILLS_DIR" cat-file -e "$LAST_SYNC" 2>/dev/null; then
    echo "Last synced from upstream at: $LAST_SYNC"
  else
    echo "Warning: .skill-sync contains invalid hash '$LAST_SYNC'. Falling back to merge-base."
    LAST_SYNC=$(git -C "$SKILLS_DIR" merge-base HEAD upstream/main 2>/dev/null || echo "HEAD")
    echo "Using: ${LAST_SYNC:0:7}"
  fi
else
  # Fall back to fork point (merge base)
  LAST_SYNC=$(git -C "$SKILLS_DIR" merge-base HEAD upstream/main 2>/dev/null || echo "HEAD")
  echo "No .skill-sync file found. Using merge base: ${LAST_SYNC:0:7}"
fi

echo ""
echo "=== New commits on upstream since last sync ==="
git -C "$SKILLS_DIR" log "$LAST_SYNC..upstream/main" --oneline || echo "(none — you're up to date)"

echo ""
echo "=== Changed skill files ==="
CHANGED=$(git -C "$SKILLS_DIR" diff --name-only "$LAST_SYNC" upstream/main -- 'skills/' 'templates/' 'scripts/' 2>/dev/null || true)

if [ -z "$CHANGED" ]; then
  echo "No skill file changes."
else
  echo "$CHANGED"
  echo ""
  echo "=== Files you've modified that may conflict ==="
  for f in $CHANGED; do
    if ! git -C "$SKILLS_DIR" diff --name-only "$LAST_SYNC" HEAD -- "$f" 2>/dev/null | grep -q .; then
      : # file not modified locally
    else
      echo "  CONFLICT RISK: $f (modified both upstream and locally)"
    fi
  done
fi

echo ""
echo "=== Sync advice ==="
echo ""
echo "Simple case (your customizations won't conflict):"
echo "  git merge upstream/main"
echo ""
echo "Files with custom changes may conflict (see above). Better than 'git checkout upstream/main --':"
echo "  git merge upstream/main           # merge, then resolve conflicts file-by-file"
echo "  # OR, for specific files:"
echo "  git diff upstream/main -- skills/engineering/<name>/  # review changes first"
echo "  git merge upstream/main           # then merge normally"
echo ""
echo "WARNING: Do NOT use 'git checkout upstream/main -- <dir>/' on customized directories."
echo "It deletes new files you added (like test-strategy.md in tdd/). Always merge, don't replace."
echo ""
echo "After syncing, update the sync marker:"
echo "  git rev-parse upstream/main > \"$SYNC_FILE\""
