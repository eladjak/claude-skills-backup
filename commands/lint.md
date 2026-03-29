---
description: Run linting and auto-fix issues
---

Check and fix linting issues.

## Commands

### Check Only
```bash
bunx ultracite check
```

### Auto-fix
```bash
bunx ultracite fix
```

### Check Specific File
```bash
bunx ultracite check <file>
```

## Full Verification

```bash
bunx tsc --noEmit && bunx ultracite check
```

## Common Issues

| Issue | Fix |
|-------|-----|
| Unused imports | Remove them |
| Missing semicolons | Auto-fix handles this |
| Inconsistent quotes | Auto-fix handles this |
| console.log | Remove before commit |
| any type | Replace with proper type |

## Process

1. Run `bunx ultracite check`
2. For auto-fixable: run `bunx ultracite fix`
3. For manual fixes: edit the files
4. Re-run until clean

## Rules

- Always run before commits
- Fix all errors, not just warnings
- Remove console.log statements
- Don't disable rules without good reason
