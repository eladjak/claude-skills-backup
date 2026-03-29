# Iteration Protocol

## Session Start
1. Read PROGRESS.md + CLAUDE.md
2. Read Kami bridge (`~/.claude/kami-bridge/messages.jsonl`) — process pending requests
3. Read MEMORY.md for relevant context
4. Announce: what capabilities/skills/MCPs are relevant for this project

## During Work
- Update PROGRESS.md every 10-15 exchanges
- Use TodoWrite for multi-step tasks
- Generate images with Gemini (nano-banana-poster) for any visual content — no placeholders
- Parallelize independent tasks with sub-agents

## Session End (MANDATORY)
1. Verify: `bunx tsc --noEmit && bunx ultracite check` (if TS project)
2. Update PROGRESS.md with full status
3. Generate Hebrew HTML review → `Documents/reports/iteration-{project}-YYYY-MM-DD.html`
4. Report milestone: `node ~/.claude/scripts/report-action.js --event milestone --project "$(basename $(pwd))" --summary "..."`

## Activation
- Auto: `[MAGIC KEYWORD: iteration-protocol]` from SessionStart hook
- Manual: `/go` command or "יאללה" / "קדימה" / "status"

## Rule
Every session: read context → work → verify → document → report.
