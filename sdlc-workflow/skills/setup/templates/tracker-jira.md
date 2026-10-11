# Issue tracker: Jira

Issues live in Jira project `<PROJECT-KEY>` at `<https://your-site.atlassian.net>`. Issue keys look like `<PROJECT-KEY>-123`.

## Transport (first available wins)

1. **Atlassian MCP** — if Jira tools are connected, use them for every operation below.
2. **CLI** — `acli jira workitem …` (Atlassian CLI) or `jira issue …` (jira-cli), whichever is installed.
3. **REST** — `curl -s -u "$JIRA_EMAIL:$JIRA_API_TOKEN" "$JIRA_BASE_URL/rest/api/3/…"`. Credentials stay in env vars; never echo them.

## Operations (REST shapes; map to MCP/CLI equivalents)

- **Create**: `POST /issue` with `project.key`, `issuetype.name` (`Story`/`Task`/`Bug`/`Epic`), `summary`, `description` (ADF or wiki markup per API version), `labels`.
- **Read**: `GET /issue/<key>?expand=renderedFields` plus `GET /issue/<key>/comment`.
- **Search**: `GET /search?jql=project=<KEY> AND labels=ready-for-agent AND statusCategory!=Done`.
- **Comment**: `POST /issue/<key>/comment`.
- **States**: use workflow **transitions** (`GET /issue/<key>/transitions` → `POST`) when the board has matching columns; otherwise use **labels** `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Record the chosen mapping here:
  - needs-triage → <status or label>
  - needs-info → <…>
  - ready-for-agent → <…>
  - ready-for-human → <…>
  - wontfix → <…>
- **Parent / child**: Epic → Story via `parent.key`; or sub-tasks (`issuetype: Sub-task`, `parent`).
- **Blocking**: `POST /issueLink` with `type.name = "Blocks"`, `inwardIssue` = blocked, `outwardIssue` = blocker.
- **Frontier**: JQL `project=<KEY> AND labels=ready-for-agent AND assignee is EMPTY AND issueFunction not in linkedIssuesOf("statusCategory != Done", "is blocked by")` — if `issueFunction` is unavailable, list candidates and filter blockers client-side via each issue's `issuelinks`.
- **Claim**: `PUT /issue/<key>/assignee` with the current account id.

## Linking from code

- Branch `{ticket}` is the issue key (`<KEY>-123-slug`). Jira's dev panel links branches, commits and PRs that contain the key.
- Commit subject or PR title carries the key per `.sdlc/config.md` → Commits.

## When a skill says…

- "publish to the issue tracker" → create a `Story` (spec: an `Epic` if it will have child tickets).
- "fetch the relevant ticket" → read the issue and its comments.
