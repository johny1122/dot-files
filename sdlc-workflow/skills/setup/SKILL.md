---
name: setup
description: Configure the SDLC pipeline for this repo and machine — code host, tracker, branching, quality gates, notes tool. Run once per repo; re-run to change a tool.
disable-model-invocation: true
---

# Setup

Explore, propose, confirm, write. Facts from the environment; the user only decides. Templates in [templates/](templates/).

## 1. Explore

- `git remote -v` → code host; default branch from `origin/HEAD`.
- CLIs (`gh`, `glab`, `az`, `jira`, `acli`) and connected MCP servers.
- Branch names (`git branch -r`) and commit style (`git log --oneline -30`).
- PR/MR template paths. Quality-gate commands from `package.json`, `Makefile`, `justfile`, `pyproject.toml`, `go.mod`, `Cargo.toml`.
- Existing `.sdlc/config.md`, `~/.sdlc/config.md`, `docs/agents/issue-tracker.md`.
- `mattpocock-skills` installed? Its model-invoked skills must be in the skill list; if not, give the install commands and stop.

## 2. User layer (first time on this machine)

If `~/.sdlc/config.md` is missing: notes tool (`obsidian` vault + folder · `repo` · `none`; recommend `repo`), author name, default commit convention, PR style. Write from [templates/config.user.md](templates/config.user.md).

## 3. Repo layer

One section, one proposal, one answer:

1. **Project** — name, base branch, one-line stack.
2. **Code host** — provider, PR template path, merge strategy, reviewers.
3. **Branching** — pattern with `{ticket}`/`{slug}`, ticket id regex.
4. **Tracker** — `github` · `gitlab` · `jira` · `linear` · `azure-boards` · `local` (default, no external deps) · `other` (user describes it). Choose `templates/tracker-*.md`.
5. **Quality gates** — typecheck, lint, single-file test, full test, build; which are required before PR. Verify each command runs.
6. **Commits** — convention and where the ticket id goes.

## 4. Write

Show both drafts, let the user edit, then write `.sdlc/config.md` from [templates/config.repo.md](templates/config.repo.md), `docs/agents/issue-tracker.md` from the tracker template, and `~/.sdlc/config.md` if step 2 ran. Ask whether `.sdlc/` is committed or ignored. `CLAUDE.md`/`AGENTS.md` are untouched — the SessionStart hook injects the config.

Done when the files exist, every gate command has been verified, and nothing a run will need reads `<unset>`. Tell the user: `/sdlc:run "<mission>"` starts a mission.
