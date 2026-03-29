---
description: Systematic debugging workflow
---

Debug issues using systematic approach.

## Process

### 1. Reproduce
- Get exact steps to reproduce
- Identify expected vs actual behavior

### 2. Locate
```
Grep: "<error message>"
Grep: "<function name>"
LSP incomingCalls: find callers
```

### 3. Understand
- Read the code with offset+limit
- Trace data flow with LSP
- Check types with hover

### 4. Hypothesize
- Form theory about root cause
- List possible causes

### 5. Test
- Add logging/breakpoints
- Verify hypothesis

### 6. Fix
- Make minimal change
- Test the fix
- Check for side effects

## Common Issues

| Symptom | Check |
|---------|-------|
| Undefined error | Null checks, optional chaining |
| Type error | Input validation, type guards |
| Async issue | await, Promise handling |
| State bug | React state updates, closures |
| Import error | Path, exports, circular deps |

## Tools

```bash
# TypeScript errors
bunx tsc --noEmit

# Runtime debugging
node --inspect src/index.ts

# Test specific file
bun test <file>
```

## Rules

- Find ROOT cause, not just symptoms
- One change at a time
- Verify fix with tests
- Don't introduce new issues
