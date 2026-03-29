---
description: Quick project and git status overview
---

Show comprehensive project status.

## Check These

### Git Status
```bash
git status
git log --oneline -5
git branch -vv
```

### Project Health
- Check for uncommitted changes
- Check if branch is ahead/behind remote
- List recent commits

### Dependencies (if applicable)
```bash
bun outdated 2>/dev/null || true
```

## Output Format

```
## Project Status

**Branch:** main (up to date with origin/main)
**Uncommitted:** 3 files modified
**Recent commits:**
- abc1234 feat: added login
- def5678 fix: button alignment

**Issues:** None / List any problems found
```

Keep it concise - just the essentials.
