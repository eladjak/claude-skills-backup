---
description: Smart codebase search with LSP and grep
---

Search the codebase intelligently.

## Search Strategy

### 1. Find Files
```
Glob: **/*<term>*.ts
Glob: **/*<term>*.tsx
```

### 2. Find Content
```
Grep: "<term>" with output_mode: "files_with_matches"
```

### 3. Find Symbols
```
LSP workspaceSymbol: "<term>"
```

### 4. Navigate (after finding location)
```
LSP goToDefinition: file:line:char
LSP findReferences: file:line:char
LSP incomingCalls: file:line:char
```

## Search Types

| Need | Tool |
|------|------|
| File by name | Glob |
| Content/string | Grep |
| Symbol/function | workspaceSymbol |
| Definition | goToDefinition |
| All usages | findReferences |
| Who calls this | incomingCalls |

## Rules

- Run searches in PARALLEL
- Use LSP for semantic understanding
- Read with offset+limit after finding location
- Narrow results with glob/type filters
