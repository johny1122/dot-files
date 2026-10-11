# Issue tracker: Azure Boards

Work items live in Azure DevOps project `<PROJECT>`, org `<ORG-URL>`. Use `az boards` (`az extension add --name azure-devops`), defaults set with `az devops configure --defaults organization=<ORG-URL> project=<PROJECT>`.

## Operations

- **Create**: `az boards work-item create --type "User Story" --title "..." --description "<html>" --fields "System.Tags=ready-for-agent"`
- **Read**: `az boards work-item show --id <n> --expand all`
- **Query**: `az boards query --wiql "SELECT [System.Id],[System.Title] FROM WorkItems WHERE [System.Tags] CONTAINS 'ready-for-agent' AND [System.State] <> 'Closed'"`
- **Comment**: `az boards work-item update --id <n> --discussion "..."`
- **States**: tags `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix` (or map to board states here).
- **Parent / child**: `az boards work-item relation add --id <child> --relation-type parent --target-id <parent>`
- **Blocking**: `--relation-type predecessor` (blocker) / `successor`.
- **Frontier**: query results with no open predecessor and no assignee.
- **Claim**: `az boards work-item update --id <n> --assigned-to <me>`

## Linking from code

- Branch `{ticket}` is `<n>`; commit/PR text `AB#<n>` links, `Fixes AB#<n>` closes on merge.

## When a skill says…

- "publish to the issue tracker" → create a work item (Feature/Epic for a spec with children).
- "fetch the relevant ticket" → `az boards work-item show --id <n> --expand all`.
