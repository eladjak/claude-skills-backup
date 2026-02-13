# Auto Memory & Progress Tracking

## CRITICAL: Always Document Progress

At the END of every significant action or before context gets full:

### 1. Update PROGRESS.md
```markdown
# Progress Log

## Last Session: [DATE]
- What was done
- Current status
- Next steps
- Blockers (if any)

## History
[Previous sessions...]
```

### 2. When Context is Getting Full
If you notice the conversation is long (50+ exchanges), proactively:
1. Create/update PROGRESS.md with full status
2. Use `/compact` or suggest compacting
3. Summarize key decisions and context

### 3. On Session Start
ALWAYS:
1. Read CLAUDE.md (project instructions)
2. Read PROGRESS.md (where we left off)
3. Read recent files modified
4. Show brief status summary
5. Continue from where we stopped

### 4. Auto-Save Triggers
Save progress when:
- Completing a major task
- Before any risky operation
- Every 10-15 exchanges
- When user seems to be ending session
- When context feels heavy

## Progress File Template

```markdown
# [Project Name] - Progress

## Status: [Active/Paused/Blocked]
## Last Updated: [Date Time]

## Current State
[2-3 sentences about where we are]

## What Was Done
- [x] Task 1
- [x] Task 2
- [ ] Task 3 (in progress)

## Next Steps
1. [Immediate next action]
2. [Following action]

## Key Decisions Made
- Decision 1: [reason]
- Decision 2: [reason]

## Files Modified
- file1.ts - [what changed]
- file2.ts - [what changed]

## Notes for Next Session
[Anything important to remember]
```

## Memory Skills Available
- `/compact` - Compress context intelligently
- `strategic-compact` skill - Suggests when to compact
- `session-memory` skill - Persists important context
- `continuous-learning` skill - Extract patterns for reuse
