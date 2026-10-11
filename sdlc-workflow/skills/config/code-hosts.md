# Code host adapters

How to perform the ship/status operations on each provider. Prefer an installed CLI; fall back to an MCP server if one is connected; fall back to the REST API with a token from the environment. Never print tokens.

## github (`gh`)

- Push & open PR: `git push -u origin <branch>` then `gh pr create --base <base> --title "<title>" --body-file <file>`; `--draft` for WIP.
- PR template: `gh` applies `.github/pull_request_template.md` only interactively — read the template yourself and fill it into `--body-file`.
- CI status: `gh pr checks <n> --watch` (or `gh run list --branch <branch>`).
- Reviews: `gh pr view <n> --json reviews,reviewDecision,mergeable`.
- Merge: `gh pr merge <n> --<merge|squash|rebase>` per config; `--auto` to merge when checks pass.
- Link an issue: put the tracker's closing keyword or ticket id in the PR body per `docs/agents/issue-tracker.md`.

## gitlab (`glab`)

- Push & open MR: `git push -u origin <branch>` then `glab mr create --target-branch <base> --title "<title>" --description-file <file>`; `--draft` for WIP.
- MR template: `.gitlab/merge_request_templates/*.md` — read and fill.
- CI status: `glab ci status --branch <branch>` / `glab ci view`.
- Approvals: `glab mr view <n>` shows approvals; merge with `glab mr merge <n> --squash|--rebase` per config; `--when-pipeline-succeeds` to auto-merge.

## bitbucket

- No first-party CLI. Use the Bitbucket MCP if connected, else REST: `POST /2.0/repositories/<ws>/<repo>/pullrequests` with `BITBUCKET_TOKEN` from env via `curl`.
- Pipelines status: `GET /2.0/repositories/<ws>/<repo>/pipelines/?target.branch=<branch>`.

## azure-devops (`az repos`)

- PR: `az repos pr create --source-branch <branch> --target-branch <base> --title "<title>" --description @<file>`; `--draft true`.
- Status: `az repos pr show --id <n>`; pipelines: `az pipelines runs list --branch <branch>`.
- Complete: `az repos pr update --id <n> --status completed --squash|--merge-commit-message`.

## none

No remote review flow. "Ship" means: quality gates green, commit on the base branch (or a patch file via `git format-patch`), tag per the release section.
