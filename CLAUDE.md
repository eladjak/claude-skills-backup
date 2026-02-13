# Claude Code Preferences

## Quick Start (Read This First)

1. **Package Manager** → `bun` only. Never npm/yarn/pnpm. Always `bun run`, `bun add`, `bunx`.
2. **Error Handling** → `better-result` for business logic. `try/catch` ONLY to wrap 3rd party calls into `Result`.
3. **Don't Guess APIs** → Context7 + Octocode FIRST when unsure about any library syntax.
4. **Parallelize** → Batch all independent tool calls in ONE message. Never sequential when parallel works.
5. **Verify** → `bunx tsc --noEmit && bunx ultracite check` before saying "done". Fix all errors.
6. **Read Smart** → Never read entire files. Use `offset` + `limit` (~30-50 lines around target).
7. **Simple Tasks** → Typo fix? Color change? Skip full workflow. See Quick Mode below.

---

## Quick Mode (For Simple Changes)

Not every task needs the full 3-phase Discovery → Navigation → Understanding workflow.

| Simple (Use Quick Mode) | Complex (Use Full Workflow) |
|-------------------------|------------------------------|
| Fix typo in text/comments | Add new feature |
| Change color/spacing/size | Refactor existing logic |
| Update a string literal | Modify data flow |
| Rename a variable (single file) | Cross-file changes |
| Toggle a boolean flag | New API integration |
| Add/remove a CSS class | Schema changes |
| Update a version number | Authentication/security work |

**Quick Mode Workflow:**
```
1. LOCATE  → Single Grep or Glob to find the exact file/line
2. EDIT    → Make the change directly
3. VERIFY  → Run typecheck + lint (if code change)
```

**Rule: If you can describe the change in one sentence and it touches ≤2 files, use Quick Mode.**

---

## Priority Order (When Starting Any Task)

```
1. UNDERSTAND → Context7 + Octocode for docs + real implementations (don't guess APIs)
2. DISCOVER   → Tree + Glob + Grep + workspaceSymbol (understand codebase)
3. NAVIGATE   → LSP tools (goToDefinition, findReferences, incomingCalls, outgoingCalls)
4. LOAD       → MCPSearch to load required MCP tools
5. LINT RULES → Ultracite rules before writing code
6. PATTERNS   → Load relevant skills (backend, UI, auth, etc.)
7. IMPLEMENT  → Write code following all loaded patterns
8. VERIFY     → Self-check (types, linting, patterns)
9. TEST       → Run typecheck + lint to confirm
```

---

## LSP Usage (MANDATORY for Code Search)

**ALWAYS use LSP tools when searching/exploring code. Never skip LSP.**

| Question | LSP Tool | MUST Use |
|----------|----------|----------|
| "Where is X defined?" | `goToDefinition` | ✓ |
| "Who uses X?" | `findReferences` | ✓ |
| "Who calls function X?" | `incomingCalls` | ✓ |
| "What does X call?" | `outgoingCalls` | ✓ |
| "What implements X?" | `goToImplementation` | ✓ |
| "What's in this file?" | `documentSymbol` | ✓ |
| "Find symbol X" | `workspaceSymbol` | ✓ |
| "Type/docs for X?" | `hover` | ✓ |
| "Call hierarchy for X?" | `prepareCallHierarchy` | ✓ |

**Workflow:**
```
1. Grep/Glob → Find file + line number
2. LSP → Navigate semantically (NEVER SKIP)
3. Read → Only after LSP, with offset+limit
```

**Rules:**
- After finding a match with Grep, ALWAYS use `goToDefinition` or `findReferences`
- NEVER just Read a file without using LSP first
- Run LSP tools in PARALLEL when investigating

---

## Rule Conflict Resolution

When rules conflict, use this priority (highest to lowest):

| Priority | Category | Example |
|----------|----------|---------|
| 1 | **Safety & Security** | Never expose credentials, even if faster |
| 2 | **Explicit User Instructions** | User says "use try/catch here" → do it |
| 3 | **Correctness** | Working code > perfect patterns |
| 4 | **Framework Requirements** | Backend requires specific patterns |
| 5 | **Project Conventions** | Existing codebase patterns |
| 6 | **CLAUDE.md Rules** | These guidelines |
| 7 | **Style Preferences** | Formatting, naming |

**Common Conflicts:**
| Conflict | Resolution |
|----------|------------|
| better-result vs framework that throws | Wrap at boundary, Result internally |
| ui-skills vs existing project patterns | Follow existing patterns, note deviation |
| Parallelize vs dependent operations | Sequential when data depends on previous |
| Quick Mode vs uncertain scope | If unsure, use full workflow |
| Context7 vs Octocode disagree | Octocode (real code) > Context7 (docs) |

---

## Autonomy Guidelines

### DECIDE AUTONOMOUSLY (don't ask):
- Which files to read/explore
- Which tools to use and in what order
- How to structure code (following loaded patterns)
- Fixing linting/type errors
- Adding missing imports
- Running typecheck/lint
- Loading MCPs and skills

### ASK USER when:
- Multiple valid architectural approaches exist
- Unclear business requirements
- Destructive actions (deleting files, dropping data)
- Changing existing behavior significantly
- Choosing between different libraries/tools
- Need credentials or sensitive info

**Rule: When in doubt about WHAT to build → Ask. When in doubt about HOW to build → Decide using patterns.**

---

## Anti-Patterns (Never Do These)

| Anti-Pattern | Instead |
|--------------|---------|
| `npm` / `yarn` / `pnpm` | `bun` |
| `try/catch` in business logic | `Result` types from better-result |
| Read entire file (no offset/limit) | Read with `offset` + `limit` (~30-50 lines) |
| Sequential tool calls when independent | Parallel tool calls in ONE message |
| Guess API syntax | Context7 + Octocode FIRST |
| Skip type check / lint | ALWAYS run `bunx tsc --noEmit && bunx ultracite check` before "done" |
| Skip LSP when searching code | ALWAYS use LSP (goToDefinition, findReferences, etc.) |
| Read file after Grep without LSP | Grep → LSP → Read (in that order) |
| `any` type | Proper TypeScript types |
| `h-screen` | `h-dvh` |
| Animate width/height/top/left | Animate transform/opacity only |
| Custom keyboard/focus handling | Use Base UI/Radix/React Aria |
| Gradients/glow without request | Plain colors, subtle shadows |
| Animation > 200ms for feedback | Keep ≤ 200ms |
| Ask when you can decide | Decide using patterns, inform user |
| Give up after one failure | Try alternatives, then ask if stuck |
| Deliver code with errors | Fix all errors first |

---

## Final Checklist

```
[ ] Using bun (not npm/yarn/pnpm)
[ ] Using better-result (not try/catch in business logic)
[ ] Loaded MCPs before calling them
[ ] Checked Context7 + Octocode for APIs
[ ] Parallelized independent tool calls
[ ] Read with offset/limit (not entire files)
[ ] Followed loaded skill patterns
[ ] Ran `bunx tsc --noEmit && bunx ultracite check`
[ ] Fixed all errors
[ ] UI accessible (if applicable)
```

---

## Auto-Invoke Rules

- **Unsure about API/syntax** → Context7 + Octocode FIRST
- **ANY JS/TS code** → `mcp__ultracite__get_rules` (linting rules)
- **Error handling** → `better-result-adopt` skill
- **Convex backend** → Convex skills + MCP (see rules/convex.md)
- **Supabase backend** → Supabase MCP (see rules/supabase.md)
- **.tsx/.jsx files** → `vercel-react-best-practices`
- **Expo/React Native** → `react-native-best-practices` + expo skills
- **Auth work (non-Supabase)** → Better Auth skills + MCP
- **Building UI** → `ui-skills` + `ui-ux-pro-max`
- **Review UI/accessibility** → `/rams` command + `web-design-guidelines` skill
- **Animation/motion** → `design-motion-principles` + Motion MCPs
- **Need icons** → Hugeicons MCPs
- **Web testing** → `agent-browser`
- **Complex tasks** → `TodoWrite`
- **Unclear requirements** → `AskUserQuestion`
- **Need MCP tools** → `MCPSearch` to load FIRST
