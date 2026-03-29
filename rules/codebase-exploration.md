# Codebase Exploration

## Phase 0: Project Structure
```bash
tree -I 'node_modules|.git|.next|dist|build|.expo|android|ios|.claude' /path/to/project
```

## Phase 1: Discovery (parallel in ONE message)
- Glob: find files by pattern (`**/*Service*.ts`)
- Grep: find content/strings
- workspaceSymbol: find symbols (NO line number needed)

## Phase 2: Navigation (parallel, after discovery)
- goToDefinition, findReferences, incomingCalls, outgoingCalls, hover
- All need exact file:line:character from Phase 1

## Phase 3: Read (ONLY after navigation)
- Use offset + limit (~30-50 lines around target)
- NEVER read entire files

## Narrowing
- Limit to directory: `glob: "src/services/**"`
- Files only first: `output_mode: "files_with_matches"`
- Exclude tests: `glob: "!**/*.test.ts"`
