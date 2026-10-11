# Maintaining this plugin

- Reinvent nothing: discipline comes from `mattpocock-skills` model-invoked skills, referenced by namespaced name (`/mattpocock-skills:tdd`). Upstream user-invoked skills (`implement`, `to-spec`, `to-tickets`, …) cannot be invoked by a skill; their processes are restated in `skills/run/phases/` and the agents — keep those in sync with upstream when it changes.
- Nothing company-specific. Tools, keys, templates and paths come from `.sdlc/config.md` / `~/.sdlc/config.md` / `docs/agents/issue-tracker.md`, written by `/sdlc:setup`. New provider = new `templates/tracker-*.md` or a section in `skills/config/code-hosts.md`.
- One phase per file; a phase ends on a checkable criterion, updates `STATE.md`, then loads the next. Never let a phase read ahead.
- Agents are listed explicitly in `plugin.json`; skills are auto-discovered.
- `claude plugin validate . --strict` before bumping `version`; update `README.md` when a phase changes.
