# Phase 4 — Tickets

Cut the spec into **tracer bullets**: each a narrow, complete path through every layer, demoable alone, sized for one fresh agent context, with its **blocking edges**. Prefactoring first. A wide mechanical refactor is sequenced expand → migrate (batches) → contract instead.

1. Draft `docs/<slug>/plans/tickets/NN-<slug>.md`, numbered in dependency order:

   ```markdown
   # NN — <title>
   **What to build:** end-to-end behaviour, user's perspective
   **Seams:** from the spec
   **Blocked by:** NN, NN — or None
   **Status:** ready
   - [ ] acceptance criterion
   ```

2. **Gate.** Show the user the spec summary and the ticket list (title · blocked by · delivers). Ask once: granularity, edges, merges/splits? Iterate until approved. This is the last question before the PR.
3. **Publish** when the tracker is not `local`: parent item from the spec, one child per ticket with native blocking links, state `ready-for-agent`, per `docs/agents/issue-tracker.md`. Record ids in the state table and `parent ticket`.
4. **Commit** `docs/<slug>/plans/` on the feature branch per the commit convention.

Done when every ticket is a file with status, edges and criteria, the user has approved, and the docs commit exists. `phase: 5` → load [5-implement.md](5-implement.md).
