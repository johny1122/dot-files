# sdlc — one command from mission to pull request

A Claude Code plugin. You give it a mission; it researches, grills you, writes the spec and tickets, implements each ticket in a fresh agent, reviews the branch, and opens the PR. You talk during grilling and approve the plan once.

Built on [mattpocock/skills](https://github.com/mattpocock/skills): `research`, `grilling`, `domain-modeling`, `prototype`, `codebase-design`, `tdd`, `code-review`, `resolving-merge-conflicts` do the work. This plugin sequences them, keeps state, and reads your tools from config — nothing company-specific inside.

## Install

```bash
claude plugin marketplace add mattpocock/skills && claude plugin install mattpocock-skills@mattpocock
claude plugin marketplace add /path/to/sdlc-workflow && claude plugin install sdlc@sdlc
```

(or `scripts/install.sh`). In a repo: `/sdlc:setup`, then `/sdlc:run "<mission>"`.

## Skills

| Skill | Role |
| --- | --- |
| `/sdlc:setup` | Once per repo: code host, tracker (default: local markdown), branching, quality gates, notes tool → `.sdlc/config.md`, `~/.sdlc/config.md`, `docs/agents/issue-tracker.md` |
| `/sdlc:run "<mission>" [--parallel]` | The pipeline. Phases below, state in `docs/<slug>/plans/STATE.md` |
| `/sdlc:resume [slug]` | Continue a run in a new session or after `/clear` |
| `/sdlc:config` | Model-invoked: loads config, holds provider adapters (`code-hosts.md`) |

## Phases of a run

| # | Phase | You | Upstream skills | Output |
| - | ----- | --- | --------------- | ------ |
| 1 | Research | — | `research` (background) | `docs/<slug>/plans/research.md`, feature branch |
| 2 | Grill | answer questions | `grilling`, `domain-modeling`, `prototype` | `CONTEXT.md`, ADRs |
| 3 | Spec | — | `codebase-design` (seams) | `plans/spec.md` |
| 4 | Tickets | **approve once** | — | `plans/tickets/NN-*.md`, tracker items, docs commit |
| 5 | Implement | — | `tdd`, `code-review` (inside **implementer** agent) | commits on the feature branch |
| 6 | Review | — | `code-review` (inside **reviewer** agent) → **implementer** fixes, ≤3 rounds | clean branch |
| 7 | PR | — | `resolving-merge-conflicts` | PR link |

One feature branch and one PR per mission. Tickets run sequentially in dependency order; `--parallel` runs unblocked tickets in worktrees and merges them back.

## Layout

```
.claude-plugin/  plugin.json, marketplace.json
agents/          implementer.md, reviewer.md
hooks/           SessionStart → scripts/session-context.sh (injects config + in-flight runs)
skills/run/      SKILL.md, STATE.md, phases/1-research.md … 7-pr.md
skills/setup/    SKILL.md, templates/ (configs, tracker adapters)
skills/resume/   skills/config/
```
