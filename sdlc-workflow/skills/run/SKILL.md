---
name: run
description: Start a mission and drive it to a pull request — research, grill, spec, tickets, implement, review, PR — with one approval gate.
argument-hint: "<mission> [--parallel]"
disable-model-invocation: true
---

# Run

One mission in, one PR out. You answer questions in the grilling phase and approve the plan once; everything else chains itself.

The discipline is upstream `mattpocock-skills`; this skill only sequences it and keeps state. Each phase lives in its own file and ends by loading the next — read only the current phase.

## Start

1. `/sdlc:config`. Derive `<slug>` from the mission (kebab, ≤5 words). Paths: plan docs `docs/<slug>/plans/`, state `docs/<slug>/plans/STATE.md`.
2. If `STATE.md` already exists, stop and point to `/sdlc:resume <slug>`.
3. Create `STATE.md` from [STATE.md](STATE.md) with the mission, flags and `phase: 1`.
4. Load [phases/1-research.md](phases/1-research.md).

## Rules for every phase

- First line of work: re-read `STATE.md`. Last line: update it (phase, artifacts, ticket ids, branch, review round). State is what `/sdlc:resume` continues from.
- Facts come from the environment; only decisions go to the user, and only in phases 2 and 4.
- Finish a phase on its completion criterion, update state, then load the next phase file. Never read ahead.
