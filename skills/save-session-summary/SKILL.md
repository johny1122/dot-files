---
name: save-session-summary
description: Save a summary of the current session (goal, related files, tasks with status, next steps, important context) to a file so a future session can resume. Use when the user asks to save/checkpoint the session, end for now and continue later, or wants a resumable summary written to disk. Accepts an optional destination directory or file path.
argument-hint: "[destination dir or file path]"
---

# Save Session Summary

Write a resumable summary of the current session to disk.

## Steps

1. Location — in priority order:
   - **Argument given** (`$ARGUMENTS`, or a destination the user stated in conversation): use it. Ends in `.md` → that's the full file path, skip step 2. Otherwise treat as a directory. Expand `~`; resolve relative paths against cwd. Create dir if missing. If the resolved parent doesn't exist or isn't writable, say so and stop — don't silently fall back.
   - **No argument**: `<cwd>/.claude/sessions-summary/` (create if missing). If cwd is the home dir (no project), use `~/.claude/sessions-summary/` instead. This folder is only for these summaries — don't put anything else in it.
2. Filename: descriptive kebab-case based on the session's main goal + today's date, e.g. `add-oauth-login-2026-07-28.md`. Never generic names like `session.md`.
3. Compose the file with these sections:
   - `## Goal` — 1-2 sentences on what this session set out to do.
   - `## Related Files` — paths touched/relevant, one-line note each on why they matter.
   - `## Tasks` — full task list (pull actual current TaskList state if tasks were tracked), `[x]` done / `[ ]` pending.
   - `## Next Steps` — concrete next actions, ordered.
   - `## Context to Preserve` — decisions made, gotchas, IDs/URLs/config values, current git branch + commit SHA (`git rev-parse --abbrev-ref HEAD` / `git rev-parse HEAD`), anything non-obvious a fresh session can't re-derive from code/git.
4. Write the file.
5. Report the absolute file path to the user in one line.

## Notes
- Skip anything trivially derivable from git log/diff — focus on decisions, why, and state.
- If multiple unrelated goals were worked on this session, either write one file covering all or split per-goal — ask the user if unclear.
