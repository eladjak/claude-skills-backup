# Troubleshooting Guide

## Common Issues

### Build Fails

```bash
# Clear cache and rebuild
rm -rf node_modules .next dist build
bun install
bun run build
```

### TypeScript Errors

```bash
# Check specific error
bunx tsc --noEmit

# Common fixes:
# - Add missing types: bun add -d @types/xxx
# - Check import paths
# - Verify tsconfig paths
```

### Dependency Issues

```bash
# Clear and reinstall
rm -rf node_modules bun.lockb
bun install

# Check for conflicts
bun outdated
```

### Git Problems

```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Discard all local changes
git checkout .
git clean -fd

# Fix detached HEAD
git checkout main
```

### Lint Failures

```bash
# Auto-fix
bunx ultracite fix

# Check specific file
bunx ultracite check src/file.ts
```

## Tool Failures

### Grep Returns Nothing

1. Try different search terms
2. Use broader glob pattern
3. Use workspaceSymbol instead
4. Check if feature exists

### LSP Not Working

1. Verify file path is correct
2. Check line numbers (1-based)
3. Use documentSymbol to list file
4. Fall back to Grep + Read

### MCP Fails

1. Check tool name spelling
2. Use ToolSearch to find correct name
3. Try alternative MCP
4. Fall back to WebSearch/WebFetch

## Recovery Strategies

### Context Lost

```
Read: .claude/cc10x/activeContext.md
Read: .claude/cc10x/patterns.md
```

### Need to Start Over

```bash
git stash
git checkout main
git checkout -b fresh-start
```

### Stuck in a Loop

1. Stop and reassess
2. Check original requirement
3. Try different approach
4. Ask user for clarification
