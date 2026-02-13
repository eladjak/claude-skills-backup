# Tool Syntax Quick Reference

## Bash (for tree)
```
command: "tree -I 'node_modules|.git|dist' /path/to/project"
```

## Glob
```
pattern: "**/*.ts"           → All TypeScript files
pattern: "**/services/**"    → All files in services folders
path: "/project/src"         → Optional: limit to directory
```

## Grep
```
pattern: "functionName"      → Regex pattern to search
glob: "src/**/*.ts"          → Limit to files matching glob
type: "ts"                   → Limit to file type
path: "/project"             → Directory to search
output_mode: "files_with_matches" | "content" | "count"
-n: true                     → Show line numbers (with content mode)
-i: true                     → Case insensitive
-A: 3                        → Lines after match
-B: 3                        → Lines before match
```

## Read
```
file_path: "/absolute/path/to/file.ts"
offset: 135                  → Start at line 135 (skip first 134)
limit: 40                    → Read only 40 lines
```

**IMPORTANT:** Always use offset + limit based on Grep/LSP results. Never read entire files.

## LSP

All LSP calls need: `filePath`, `line` (1-based), `character` (1-based)

```
operation: "goToDefinition" | "findReferences" | "goToImplementation" |
           "incomingCalls" | "outgoingCalls" | "hover" |
           "documentSymbol" | "workspaceSymbol"
filePath: "/absolute/path/to/file.ts"
line: 42
character: 10
```

**Note:** `documentSymbol` and `workspaceSymbol` don't need exact line/character - just use line: 1, character: 1

## MCPSearch

**IMPORTANT:** MCP tools are NOT loaded by default. Use `MCPSearch` to load them BEFORE calling.

```
MCPSearch query: "select:mcp__context7__query-docs"  → Load specific tool
MCPSearch query: "convex"                            → Search for convex tools
```

## TypeScript Project - Key Files Checklist

When first exploring a TypeScript project, check these in parallel:
```
[Read: package.json]        → Dependencies, scripts, project info
[Read: tsconfig.json]       → Paths, aliases, compiler options
[Glob: **/index.ts]         → Entry points
[Glob: **/types/**/*.ts]    → Type definitions
[Glob: **/*.d.ts]           → Declaration files
```
