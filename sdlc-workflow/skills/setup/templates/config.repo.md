# SDLC — repo config

Read by `/sdlc:run` and `/sdlc:resume`. Edit freely; re-run `/sdlc:setup` to switch a tool.

## Project
- name: <unset>
- base branch: main
- stack: <unset>

## Code host
- provider: <unset>          # github | gitlab | bitbucket | azure-devops | none
- pr template: none          # path or none
- merge strategy: squash
- reviewers: <unset>         # CODEOWNERS | names | none

## Branching
- pattern: {ticket}-{slug}   # {ticket} drops out when no tracker id exists
- ticket id regex: <unset>   # e.g. [A-Z]+-\d+ or \d+

## Tracker
- provider: local            # github | gitlab | jira | linear | azure-boards | local | other
- project: <unset>           # key / repo / team / board
- operations: docs/agents/issue-tracker.md

## Quality gates
- typecheck: <unset>
- lint: <unset>
- test (single file): <unset>
- test (full): <unset>
- build: <unset>
- required before PR: typecheck, lint, test (full)

## Commits
- convention: conventional   # conventional | ticket-prefix | freeform
- ticket placement: body     # subject | body | trailer | none

## Notes
- override: none             # replaces the user default for this repo
