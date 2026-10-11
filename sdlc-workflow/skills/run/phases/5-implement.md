# Phase 5 — Implement

One `implementer` agent per ticket, fresh context each, on the feature branch. Default order: ticket numbers, blockers first.

For each ticket with every blocker `done`:

1. Launch the **implementer** agent with: the ticket file, `spec.md`, `CONTEXT.md` path, the config (gates, commit convention), the branch name, and "work directly on this branch; do not push or open a PR".
2. On return, read its report. Gates red or criteria unmet → relaunch once with the report attached. Still red → stop, write the blocker to state, ask the user.
3. Mark the ticket `done` in its file and the state table; post the report as a comment on the tracker ticket when there is one.

`--parallel`: launch all currently unblocked tickets at once, each implementer in its own worktree on a branch `<feature>/<NN>`; merge each back into the feature branch in number order, resolving conflicts with `/mattpocock-skills:resolving-merge-conflicts`; run the full gate set after the last merge.

Done when every ticket is `done`, every gate marked *required before PR* is green on the feature branch, and the state table matches. `phase: 6`, `review round: 0` → load [6-review.md](6-review.md).
