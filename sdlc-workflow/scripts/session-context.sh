#!/usr/bin/env bash
# SessionStart hook: surface SDLC config and any in-flight runs. Silent when the repo isn't set up.
root="${CLAUDE_PROJECT_DIR:-$PWD}"
cfg="$root/.sdlc/config.md"
[ -f "$cfg" ] || exit 0
echo "<sdlc-config source=\"$cfg\">"; cat "$cfg"; echo "</sdlc-config>"
[ -f "$HOME/.sdlc/config.md" ] && { echo "<sdlc-user-config>"; cat "$HOME/.sdlc/config.md"; echo "</sdlc-user-config>"; }
runs=$(ls "$root"/docs/*/plans/STATE.md 2>/dev/null)
if [ -n "$runs" ]; then
  echo "<sdlc-runs>"
  for f in $runs; do printf '%s: %s\n' "$f" "$(grep -m1 '^- phase:' "$f")"; done
  echo "</sdlc-runs>"
  echo "In-flight SDLC runs above. /sdlc:resume continues one; /sdlc:run starts a new mission."
fi
