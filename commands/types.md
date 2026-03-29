---
description: Run TypeScript type checking
---

Check TypeScript types and fix errors.

## Commands

### Full Check
```bash
bunx tsc --noEmit
```

### Watch Mode
```bash
bunx tsc --noEmit --watch
```

### Specific File
```bash
bunx tsc --noEmit <file.ts>
```

## Common Fixes

| Error | Fix |
|-------|-----|
| `Cannot find module` | Check import path, add to tsconfig paths |
| `Type X not assignable to Y` | Fix type mismatch or add type assertion |
| `Property does not exist` | Add property to interface or use optional chaining |
| `Argument of type` | Match expected parameter type |
| `Object is possibly undefined` | Add null check or optional chaining |

## Process

1. Run `bunx tsc --noEmit`
2. Read each error message
3. Navigate to file:line with LSP
4. Fix the specific error
5. Re-run until clean

## Rules

- Fix ALL errors before saying done
- Never use `any` unless absolutely necessary
- Prefer type inference when clear
- Use `unknown` instead of `any` for unknown types
