---
name: sync-repos-to-main
description: Update every git repo directly under a folder (default the current directory) to its default branch (main/master) via a fast-forward git pull, then report which repos could not be updated and why (uncommitted changes, diverged history, no remote, etc). Use when the user asks to update/sync/pull all repos in a folder, or asks which local repos have changes/conflicts blocking an update.
tools: Bash, Read
---

# Sync Repos to Main

Fast-forward every git repository found one level below a target directory to its
default branch, without ever merging, rebasing, or touching uncommitted work. Anything
that can't be safely fast-forwarded is reported with a specific reason instead of being
forced through.

## Workflow

1. Run the bundled script against the target directory (defaults to `.`):

   ```bash
   bash "$SKILL_DIR/scripts/update-repos.sh" <target_dir>
   ```

   Replace `$SKILL_DIR` with this skill's own directory (the directory containing this
   SKILL.md), and `<target_dir>` with the folder the user means (usually the current
   working directory — omit the argument to default to `.`).

   For each immediate subdirectory that is a git repo, the script:
   - Fetches `origin`.
   - Skips (does not touch) any repo with uncommitted changes — it never stashes or
     discards local work.
   - Checks out the default branch (`main`, falling back to `master`) if not already on
     it, as long as the working tree is clean.
   - Fast-forwards (`git merge --ff-only`) to `origin/<default branch>`. It never
     performs a real merge or rebase, so it can never create a merge conflict.
   - Prints one line per repo: `OK|<repo>|<message>` for repos that are now up to date,
     or `SKIP|<repo>|<reason>` for repos that were left untouched.

2. Parse the script's output and present it to the user as two lists:
   - **Updated** — repos with an `OK|` line (include whether they were already current
     or how many commits were pulled).
   - **Needs attention** — repos with a `SKIP|` line, each with its specific reason
     (e.g. uncommitted changes, diverged from origin, no remote configured, no
     main/master branch, unpushed local commits).

   If a repo directory couldn't be entered or the script itself errored, surface that
   line too rather than silently dropping it.

3. Do not attempt to auto-resolve anything in the "needs attention" list (e.g. don't
   stash changes, don't force-merge diverged branches) — those require a decision only
   the user can make. Just report the reason clearly so they know what to do next.
