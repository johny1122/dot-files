# Phase 1 — Research

Learn the subject before asking anything.

1. **Codebase.** Read `CONTEXT.md`, `docs/adr/`, and the modules the mission touches, in that order. Note the vocabulary and the seams you see.
2. **Primary sources.** Run `/mattpocock-skills:research` with the mission's open questions (APIs, libraries, specs, prior art). Tell it to save to `docs/<slug>/plans/research.md`. It runs in the background; do not wait.
3. **Branch.** `git fetch`, then create the feature branch from the fresh base using the config pattern (`{ticket}` drops out until a parent ticket exists; `{slug}` = `<slug>`). Record `branch` and `base` in state.

Done when the branch exists, research is running, and you can name the modules and terms involved. `phase: 2` → load [2-grill.md](2-grill.md).
