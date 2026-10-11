# Phase 7 — Pull request

1. **Preflight.** `git fetch`; rebase the feature branch on the base; conflicts via `/mattpocock-skills:resolving-merge-conflicts`; run the gates marked *required before PR* one last time.
2. **Body.** If the config names a PR template, read it and fill it heading by heading. Otherwise: *What* · *Why* (link `spec.md`) · *Tickets* (ids, each with its status) · *How tested* (gate commands + results, reviewer verdict) · *Risk & rollback*. Link the parent ticket with the tracker's closing keyword when there is one.
3. **Open** via the provider adapter in `/sdlc:config` → `code-hosts.md`: push, create as draft or ready per the user default, set reviewers if config names them. Record `pr` in state; comment the link on the parent ticket.
4. **Mirror** plan docs to the notes tool if configured.
5. `phase: done`. Tell the user: PR link, tickets shipped, review rounds, anything the reviewer flagged as *consider*.

Done when the PR URL is in state and reported. Nothing further runs; merging is the user's call.
