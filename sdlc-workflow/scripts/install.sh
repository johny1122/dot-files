#!/usr/bin/env bash
# Install the sdlc plugin and its dependency into Claude Code on a new machine.
set -euo pipefail
here="$(cd "$(dirname "$0")/.." && pwd)"
claude plugin marketplace add mattpocock/skills || true
claude plugin install mattpocock-skills@mattpocock || true
claude plugin marketplace add "$here" || true
claude plugin install sdlc@sdlc
echo "Done. Open any repo and run /sdlc:setup."
