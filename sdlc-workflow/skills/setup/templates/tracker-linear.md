# Issue tracker: Linear

Issues live in Linear team `<TEAM-KEY>`. Identifiers look like `<TEAM-KEY>-123`.

## Transport (first available wins)

1. **Linear MCP** — if connected, use it for everything below.
2. **GraphQL** — `curl -s -H "Authorization: $LINEAR_API_KEY" -H "Content-Type: application/json" https://api.linear.app/graphql -d '{"query": "…"}'`. Key stays in env.

## Operations

- **Create**: `issueCreate(input: {teamId, title, description, labelIds, parentId, projectId})`.
- **Read**: `issue(id)` with `comments`, `labels`, `state`, `relations`, `children`.
- **List**: `issues(filter: {team: {key: {eq: "<TEAM-KEY>"}}, labels: {name: {eq: "ready-for-agent"}}, state: {type: {neq: "completed"}}})`.
- **Comment**: `commentCreate(input: {issueId, body})`.
- **States**: workflow states where names match; otherwise labels `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix` (map here if names differ).
- **Parent / child**: `parentId` (sub-issues).
- **Blocking**: `issueRelationCreate(input: {issueId: <blocked>, relatedIssueId: <blocker>, type: blocks})`.
- **Frontier**: candidates from the list query; drop any with an incomplete `blocks` relation pointing at it or an assignee.
- **Claim**: `issueUpdate(id, input: {assigneeId: <me>})`.

## Linking from code

- Branch `{ticket}` is the identifier (Linear auto-links branches named `<TEAM-KEY>-123-…`); PR body `Fixes <TEAM-KEY>-123` closes on merge.

## When a skill says…

- "publish to the issue tracker" → create an issue (a parent issue for a spec with children).
- "fetch the relevant ticket" → read the issue with comments.
