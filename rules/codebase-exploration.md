# Codebase Exploration Workflow

When exploring or debugging in large codebases, use this 3-phase approach with maximum parallelization.

## Phase 0: Project Structure (first time exploring)

```bash
tree -I 'node_modules|.git|.next|dist|build|.expo|android|ios|.claude|_generated|.vscode' /path/to/project
```

**Common ignore patterns:**
| Project Type | Ignore Pattern |
|--------------|----------------|
| Node/JS | `node_modules\|dist\|build\|.next\|coverage` |
| React Native/Expo | `node_modules\|.expo\|android\|ios\|build` |
| Python | `__pycache__\|.venv\|venv\|.pytest_cache\|dist` |

## Phase 1: Discovery (run in parallel)

| Tool | Use For | Example |
|------|---------|---------|
| `Glob` | Find files by pattern | `**/*Service*.ts`, `src/**/*.tsx` |
| `Grep` | Find files/lines containing term | Error messages, function names |
| `workspaceSymbol` | Find symbols by name (NO line number needed) | Find all `*Handler` classes |

**Discovery in ONE message:**
```
[Bash: tree -I '...' /project]       → Project structure
[Glob: **/*Service*.ts]              → Find service files
[Glob: **/*Controller*.ts]           → Find controller files
[Grep: "handleError"]                → Find error handling
[Grep: "ValidationError"]            → Find validation logic
[LSP workspaceSymbol: "Handler"]     → Find all Handler symbols
```

## Phase 2: Navigation (run in parallel, after discovery)

| Tool | Use For | Needs Line Number? |
|------|---------|-------------------|
| `goToDefinition` | Where is it defined | Yes |
| `findReferences` | All usages of symbol | Yes |
| `goToImplementation` | What implements interface | Yes |
| `incomingCalls` | Who CALLS this function | Yes |
| `outgoingCalls` | What this function CALLS | Yes |
| `hover` | Type info and documentation | Yes |
| `documentSymbol` | List all symbols in a file | No (just file path) |

**Navigation in ONE message:**
```
[LSP goToDefinition: file.ts:42:10]     → Where defined
[LSP findReferences: file.ts:42:10]     → All usages
[LSP incomingCalls: file.ts:42:10]      → Who calls it
[LSP outgoingCalls: file.ts:42:10]      → What it calls
[LSP documentSymbol: other-file.ts]     → What's in this file
```

## Phase 3: Understanding (only when needed)

**IMPORTANT: Use `offset` and `limit` parameters based on Grep/LSP results:**
```
Grep found match at line 142
LSP shows function spans lines 138-165

→ Read with offset=135, limit=35 (read lines 135-170 only)
```

**Rules:**
- Only read AFTER discovery + navigation
- **Use offset + limit** - Read ~30-50 lines around the target, NOT entire file
- Get line numbers from Grep/LSP first, then calculate offset

## Complete Parallel Patterns

### Investigating a function (ONE message)
```
[Grep: "functionName"]
[LSP goToDefinition]
[LSP findReferences]
[LSP incomingCalls]
[LSP outgoingCalls]
[LSP hover]
```

### Investigating a type/interface (ONE message)
```
[Grep: "TypeName"]
[LSP goToDefinition]
[LSP findReferences]
[LSP goToImplementation]
```

### Exploring unknown codebase (ONE message)
```
[Glob: src/**/*.ts]
[Glob: **/*config*]
[Grep: "export class"]
[Grep: "export function"]
[LSP workspaceSymbol: "Service"]
[LSP workspaceSymbol: "Controller"]
```

### Debugging an error (ONE message)
```
[Grep: "ErrorMessage text"]
[Grep: "throw new"]
[LSP workspaceSymbol: "Error"]
```
Then after getting locations:
```
[LSP goToDefinition: error-location]
[LSP incomingCalls: error-location]
[Read: file.ts, offset=135, limit=40]
```

## LSP Decision Tree

```
"Where is X defined?"           → goToDefinition
"Who uses X?" (any symbol)      → findReferences
"Who CALLS X?" (function)       → incomingCalls
"What does X call?"             → outgoingCalls
"What implements X?"            → goToImplementation
"What's in this file?"          → documentSymbol
"Find symbol X in workspace"    → workspaceSymbol (NO line number needed!)
"Type/docs for X?"              → hover
```

## Tool Strengths & Weaknesses

| Tool | Strength | Weakness |
|------|----------|----------|
| `Glob` | Fast file pattern matching | Only finds files, not content |
| `Grep` | Fast, searches everywhere | Noisy, no semantic context |
| `workspaceSymbol` | Finds symbols without line numbers | Only symbols, not strings |
| `LSP navigation` | Precise, semantic understanding | Needs exact line+character |
| `Read` | Full comprehension | Slow, uses context |

## Narrowing Strategy (When Too Many Results)

| Strategy | How |
|----------|-----|
| **Limit to directory** | `glob: "src/services/**"` |
| **Limit to file type** | `type: "ts"` |
| **Files only first** | `output_mode: "files_with_matches"` |
| **More specific pattern** | `"handleError"` → `"function handleError"` |
| **Exclude tests** | `glob: "!**/*.test.ts"` |

## Golden Rules

1. **Parallelize everything** - Run all independent tool calls in ONE message
2. **Discovery first** - Glob + Grep + workspaceSymbol before LSP navigation
3. **Read last** - Only after you know exactly what to read
4. **Never read entire files** - Use `offset` + `limit` (~30-50 lines)
5. **Use workspaceSymbol** - Doesn't need line numbers, great for initial exploration
6. **Line numbers drive everything** - Grep/LSP give line numbers → LSP navigation → targeted Read
