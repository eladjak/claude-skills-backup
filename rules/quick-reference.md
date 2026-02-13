# Quick Reference Card

## Most Used Commands

```
/commit    → Create git commit
/pr        → Create pull request
/status    → Project status
/review    → Code review
/test      → Generate tests
/fix       → Debug issues
/search    → Search codebase
```

## Verification (ALWAYS run before "done")

```bash
bunx tsc --noEmit && bunx ultracite check
```

## Tool Priority

1. **Glob** → Find files by pattern
2. **Grep** → Find content/strings
3. **LSP** → Navigate code (definitions, references)
4. **Read** → Read file (with offset+limit!)
5. **Edit** → Make changes

## LSP Quick Reference

| Need | Tool |
|------|------|
| Definition | goToDefinition |
| All usages | findReferences |
| Who calls | incomingCalls |
| What it calls | outgoingCalls |
| File symbols | documentSymbol |
| Find symbol | workspaceSymbol |

## Parallel Rules

- Independent calls → ONE message
- Dependent calls → Sequential
- Multiple files → Read in parallel
- Multiple searches → Search in parallel

## Read with Offset

```
Grep found line 142
→ Read with offset=135, limit=40
```

## MCP Loading

```
ToolSearch(query="select:mcp__context7__query-docs")
```

## Error Handling

```typescript
// Business logic → Result types
// 3rd party boundaries → try/catch → Result
```

## Package Manager

```bash
bun install    # not npm/yarn
bun add        # add package
bun run        # run script
bunx           # run binary
```
