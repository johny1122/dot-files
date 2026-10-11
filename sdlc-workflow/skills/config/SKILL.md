---
name: config
description: Load the SDLC tool configuration — code host, tracker, branch pattern, quality gates, notes tool. Use when a phase needs a tool, command or destination, or when another skill says "load the SDLC config".
---

# SDLC config

Two layers, repo over user:

1. `.sdlc/config.md` — code host, branching, tracker, quality gates, notes override.
2. `~/.sdlc/config.md` — identity, notes tool, personal defaults.

Tracker operations (create/read/label/link) live in `docs/agents/issue-tracker.md`, the path upstream `code-review` also reads.

## Steps

1. Read all three files, or use the `<sdlc-config>` block if the SessionStart hook already injected them.
2. `.sdlc/config.md` missing → stop; tell the user to run `/sdlc:setup`.
3. Resolve what the caller needs. PR and CI commands per provider: [code-hosts.md](code-hosts.md). Tracker: `docs/agents/issue-tracker.md`.

Done when every tool call about to be made has provider, command and destination from config, none assumed. A field reading `<unset>` → ask once, offer to write the answer back.

## Notes tool

`~/.sdlc/config.md` → Notes names where plan docs are mirrored after the PR opens: `obsidian` (vault + folder → copy `docs/<slug>/plans/*.md` there with frontmatter `project`, `kind`, `date`, `source`), `repo` (they already live in the repo; nothing to do), `none`.
