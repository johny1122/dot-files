# Phase 6 — Review

Whole-branch review against the base, by the **reviewer** agent, which drives upstream `/mattpocock-skills:code-review` and verifies the tests.

1. Increment `review round`. Launch the reviewer with: base branch, `spec.md`, the tickets directory, the gate commands.
2. Read its report. Zero blockers and zero failed criteria → done.
3. Otherwise launch one **implementer** with the findings as its ticket ("address these review findings on the feature branch"), then go to 1. After round 3 with blockers remaining, stop and hand the report to the user.

Done when the latest reviewer report has no blocker and no failed acceptance criterion. `phase: 7` → load [7-pr.md](7-pr.md).
