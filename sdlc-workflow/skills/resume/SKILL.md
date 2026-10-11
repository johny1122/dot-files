---
name: resume
description: Continue an in-flight SDLC run from its state file after a context clear or in a new session.
argument-hint: "[slug]"
disable-model-invocation: true
---

# Resume

1. `/sdlc:config`. Find the run: `docs/<slug>/plans/STATE.md` from `$ARGUMENTS`, else list every `docs/*/plans/STATE.md` with its phase and let the user pick (one run → take it).
2. Read `STATE.md`, `spec.md` if it exists, and the ticket table. Check out the recorded branch. Reconcile state with reality: tickets whose files say `done`, gates, an existing PR — fix the table before continuing.
3. Load `phases/<phase>-*.md` from the `run` skill folder (`${CLAUDE_PLUGIN_ROOT}/skills/run/phases/`) and continue under the same rules as `/sdlc:run`.

Done when the phase file is loaded and work has restarted from the first unfinished step.
