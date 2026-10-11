# Phase 3 — Spec

Synthesize; do not interview. Write `docs/<slug>/plans/spec.md` from this conversation in the glossary's vocabulary, respecting ADRs:

```markdown
## Problem Statement      — from the user's perspective
## Solution               — from the user's perspective
## User Stories           — long numbered list: As a <actor>, I want <feature>, so that <benefit>
## Implementation Decisions — modules and interface changes, contracts, schema, architecture (link ADRs)
## Testing Decisions      — the seams (below), what a good test is here, prior art to mirror
## Out of Scope
## Further Notes          — risks, rollout, migration, observability
```

**Seams**: using `/mattpocock-skills:codebase-design` vocabulary, pick where the feature is tested — existing seams first, the highest possible, the fewest possible (ideal: one). They are the only places tests will be written.

No file paths or code; a prototype snippet that encodes a decision is the one exception.

Done when `spec.md` exists with every section filled and the seams named. `phase: 4` → load [4-tickets.md](4-tickets.md).
