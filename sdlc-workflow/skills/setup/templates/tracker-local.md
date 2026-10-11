# Issue tracker: local markdown

No external tracker. Tickets are the files `/sdlc:run` writes under `docs/<slug>/plans/tickets/NN-<slug>.md`; the spec is `docs/<slug>/plans/spec.md`; run state is `docs/<slug>/plans/STATE.md`.

## Operations

- **Create**: write the file; `NN` is the next free number in that run.
- **Read / list**: read the files; `grep -l "Status: ready" docs/*/plans/tickets/*.md`.
- **Comment**: append under `## Notes` with a date line.
- **States**: the `**Status:**` line — `ready`, `in-progress`, `done`, `blocked`.
- **Blocking**: the `**Blocked by:**` line.
- **Frontier**: `ready` tickets whose blockers are all `done`.

## When a skill says…

- "publish to the issue tracker" → nothing beyond the files (they are the tracker).
- "fetch the relevant ticket" → read the file.
- "closing keyword" → none; link the spec path in the PR body.
