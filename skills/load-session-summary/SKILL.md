---
name: load-session-summary
description: Load a previously saved session summary to resume work where it left off. Use when the user asks to resume/continue a previous session, load session context, or pick up where they left off. Accepts an optional source directory or file path.
argument-hint: "[source dir or file path]"
---

# Load Session Summary

Resume a previous session from a saved summary file.

## Steps

1. Where to look — in priority order:
   - **Argument given** (`$ARGUMENTS`, or a source the user stated in conversation): use it, and only it. Ends in `.md` → read that file directly, skip to step 4. Otherwise search that directory. Expand `~`; resolve relative paths against cwd. Missing path or no `.md` files in it → say so and stop; don't fall back to the default locations without telling the user.
   - **No argument**: search BOTH default locations (a summary may have been saved from a different cwd):
     - `<cwd>/.claude/sessions-summary/` (project-local)
     - `~/.claude/sessions-summary/` (global fallback)
2. None exist in either → tell user, stop.
3. One exists → load it. Multiple exist → list filenames + their `## Goal` line (note which location each came from), ask which to resume (unless user already named one).
4. Read the chosen file and:
   - Restate the Goal back to the user in one line.
   - If tasks are tracked this session, recreate the task list (mark previously-done items completed).
   - Surface Next Steps and relevant Context to Preserve items.
5. Proceed with (or ask about) the first pending next step, per user preference.

## Notes
- Treat the file as a snapshot — verify file paths/facts still hold (things may have changed since saving) before acting on them.
