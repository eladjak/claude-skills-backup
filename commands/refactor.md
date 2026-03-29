---
description: Refactor code safely
---

Refactor code while maintaining behavior.

## Process

### 1. Understand
- Read the code thoroughly
- Identify what needs refactoring
- Understand current behavior

### 2. Plan
- Define target state
- Break into small steps
- Identify risks

### 3. Test First
- Ensure tests exist
- Run tests (they should pass)
- Add tests if missing

### 4. Refactor
- Small, incremental changes
- One thing at a time
- Run tests after each change

### 5. Verify
- All tests still pass
- Behavior unchanged
- Code is cleaner

## Common Refactors

| Pattern | When |
|---------|------|
| Extract function | Repeated code, long functions |
| Extract component | Reusable UI logic |
| Rename | Unclear names |
| Move | Wrong location |
| Inline | Over-abstraction |
| Split file | File too large (>400 lines) |

## Rules

- **Never** change behavior while refactoring
- **Always** have tests before refactoring
- **One** type of change at a time
- **Run** tests after each step
- **Commit** frequently

## Red Flags

- File > 400 lines → Split
- Function > 50 lines → Extract
- Nesting > 4 levels → Flatten
- Duplicate code → Extract
- Unclear names → Rename
