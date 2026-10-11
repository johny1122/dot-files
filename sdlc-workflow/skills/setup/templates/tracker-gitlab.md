# Issue tracker: GitLab Issues

Issues live in this project's GitLab Issues. Use the `glab` CLI; it infers the project from the clone.

## Operations

- **Create**: `glab issue create --title "..." --description-file <file> --label <label>`
- **Read**: `glab issue view <n> --comments`
- **List**: `glab issue list --label <label> --output json`
- **Comment**: `glab issue note <n> --message-file <file>`
- **Labels**: `glab issue update <n> --label "..." --unlabel "..."`
- **Close**: `glab issue close <n>`
- **Parent / child**: use an epic or `Part of #<parent>` in the child description.
- **Blocking**: `glab api --method POST projects/:id/issues/<child>/links -f target_issue_iid=<blocker> -f link_type=is_blocked_by`.
- **Frontier**: open issues labelled `ready-for-agent`, no open `is_blocked_by` link, unassigned.
- **Claim**: `glab issue update <n> --assignee @me`

## Triage states

Labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Category: `bug`, `enhancement`.

## Linking from code

- Branch `{ticket}` is `<n>`; MR description `Closes #<n>` closes on merge.

## When a skill says…

- "publish to the issue tracker" → create an issue.
- "fetch the relevant ticket" → `glab issue view <n> --comments`.
