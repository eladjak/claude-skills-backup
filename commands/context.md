---
description: Manage session context and memory
---

View and manage session context.

## View Current Context

```
Read(file_path=".claude/cc10x/activeContext.md")
Read(file_path=".claude/cc10x/patterns.md")
Read(file_path=".claude/cc10x/progress.md")
```

## Update Context

### Add to Active Context
```
Edit(file_path=".claude/cc10x/activeContext.md", ...)
```

### Record Pattern
```
Edit(file_path=".claude/cc10x/patterns.md", ...)
```

### Update Progress
```
Edit(file_path=".claude/cc10x/progress.md", ...)
```

## Context Structure

### activeContext.md
- Current task/feature
- Recent decisions
- Open questions
- References to plans

### patterns.md
- Project architecture
- Code patterns used
- Naming conventions
- File organization

### progress.md
- Completed tasks
- Current status
- Next steps
- Blockers

## Tips

- Update context after significant changes
- Reference file:line for code locations
- Keep context concise and current
- Clear outdated information
