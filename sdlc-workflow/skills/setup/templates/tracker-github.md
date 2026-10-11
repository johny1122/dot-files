# Issue tracker: GitHub Issues

Issues, specs and tickets live as GitHub Issues in this repo. Use the `gh` CLI; it infers the repo from the clone.

## Operations

- **Create**: `gh issue create --title "..." --body-file <file> --label <label>`
- **Read**: `gh issue view <n> --comments`
- **List**: `gh issue list --state open --label <label> --json number,title,labels,assignees`
- **Comment**: `gh issue comment <n> --body-file <file>`
- **Labels**: `gh issue edit <n> --add-label "..." --remove-label "..."` (create missing labels with `gh label create`)
- **Close**: `gh issue close <n> --comment "..."`
- **Parent / child**: GitHub sub-issues via `gh api repos/{owner}/{repo}/issues/<parent>/sub_issues -f sub_issue_id=<child-db-id>`; fall back to `Part of #<parent>` at the top of the child body.
- **Blocking**: native dependencies via `gh api --method POST repos/{owner}/{repo}/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>` (db id from `gh api repos/{owner}/{repo}/issues/<n> --jq .id`); fall back to a `Blocked by: #a, #b` line.
- **Frontier** (ready to start): open issues labelled `ready-for-agent` with no open blocker and no assignee.
- **Claim**: `gh issue edit <n> --add-assignee @me`

## Triage states

Labels, one per issue: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Category labels: `bug`, `enhancement`.

## Linking from code

- Branch: ticket id is `<n>`; branch pattern uses it as `{ticket}` (e.g. `123-slug`).
- Commit / PR body: `Closes #<n>` closes on merge.

## When a skill says…

- "publish to the issue tracker" → create an issue.
- "fetch the relevant ticket" → `gh issue view <n> --comments`.
