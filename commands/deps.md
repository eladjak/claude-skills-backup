---
description: Check and manage project dependencies
---

Analyze and manage project dependencies.

## Commands

### Check Outdated
```bash
bun outdated
```

### Check for Issues
```bash
bun install --dry-run
```

### Update All
```bash
bun update
```

### Update Specific
```bash
bun update <package>
```

### Add New
```bash
bun add <package>
bun add -d <package>  # dev dependency
```

### Remove
```bash
bun remove <package>
```

## Security Check

```bash
bunx audit
```

## Analysis Output

```
## Dependencies Status

**Total:** X packages
**Outdated:** Y packages need updates
**Security:** Z vulnerabilities found

### Updates Available
| Package | Current | Latest | Type |
|---------|---------|--------|------|
| react | 18.2.0 | 18.3.0 | minor |

### Recommendations
- [list any security fixes needed]
- [list breaking changes to watch for]
```
