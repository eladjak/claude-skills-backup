---
description: Trigger autonomous improvement cycle
---

Start or continue autonomous improvement of Claude Code setup.

## Usage

```
/self-improve        # Run one cycle
/self-improve auto   # Run continuously
/self-improve stop   # Stop autonomous mode
```

## What Gets Created

Each cycle adds:
- 5-10 new commands
- 2-4 new agents
- 2-4 new skills
- 0-2 new rules

## Categories

### High Priority
- Missing common workflows
- Requested features
- Error-prone patterns

### Medium Priority
- Framework support
- Tool integrations
- Convenience utilities

### Low Priority
- Edge cases
- Niche tools
- Advanced patterns

## Cycle Report

After each cycle:
```
✓ Created: 8 commands, 3 agents, 2 skills
✓ Updated: SKILLS_INDEX.md
⏳ Next cycle in 5 minutes...

Type 'stop' to pause autonomous mode.
```
