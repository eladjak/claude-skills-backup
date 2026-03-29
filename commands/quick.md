---
description: Quick mode for simple changes
---

Use Quick Mode for simple, obvious changes.

## When to Use Quick Mode

| ✓ Quick Mode | ✗ Full Workflow |
|--------------|-----------------|
| Fix typo | Add new feature |
| Change color/size | Refactor logic |
| Update string | Cross-file changes |
| Toggle boolean | New API integration |
| Rename (single file) | Schema changes |

## Quick Mode Workflow

```
1. LOCATE → Single Grep or Glob
2. EDIT → Make the change
3. VERIFY → bunx tsc --noEmit && bunx ultracite check
```

## Examples

### Fix Typo
```
Grep: "teh" → Find typo
Edit: "teh" → "the"
```

### Change Color
```
Grep: "#ff0000" → Find red
Edit: "#ff0000" → "#00ff00"
```

### Update Version
```
Read: package.json (lines around version)
Edit: "1.0.0" → "1.0.1"
```

## Rule

**If you can describe the change in one sentence and it touches ≤2 files, use Quick Mode.**

Skip the full exploration workflow for obvious changes.
