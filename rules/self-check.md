# Self-Check, Error Recovery & Testing

## Self-Check Before Finishing

Before saying "done", verify:

### Code Quality
- [ ] Follows Ultracite linting rules
- [ ] Uses better-result for error handling (no try/catch in business logic)
- [ ] TypeScript types are correct (no `any` unless necessary)
- [ ] Follows loaded skill patterns (backend, React, UI, etc.)

### UI (if applicable)
- [ ] Follows ui-skills constraints
- [ ] Accessible (aria-labels, keyboard nav, focus states)
- [ ] Uses correct primitives (Base UI, Radix, React Aria)
- [ ] Animations only on transform/opacity, max 200ms

### Backend (if applicable)
- [ ] Schema is properly typed
- [ ] Queries/mutations follow patterns
- [ ] Security rules applied

### Completeness
- [ ] All imports added
- [ ] No placeholder/TODO code left
- [ ] Edge cases handled
- [ ] Error states handled with Result types

---

## Error Recovery (When Tools Fail)

### If Grep returns nothing:
1. Try different search terms (synonyms, partial matches)
2. Try broader glob pattern
3. Use `workspaceSymbol` instead
4. Check if file/feature exists at all

### If LSP returns nothing:
1. Verify file path is correct
2. Check line/character numbers are 1-based
3. Try `documentSymbol` to list file contents first
4. Fall back to Grep + Read

### If MCP fails to load:
1. Check MCP name is correct
2. Try `MCPSearch` with keyword search
3. Use alternative (WebSearch/WebFetch for docs)

### If `tsc --noEmit` or `ultracite check` fails:
1. Read the error message carefully
2. Fix the specific error
3. Re-run to verify fix
4. Don't move on until passing

**Rule: Never give up after one failure. Try alternatives, then ask user if stuck.**

---

## Testing After Changes

### After writing code:
```bash
bunx tsc --noEmit && bunx ultracite check   # types + linting
```

### If tests exist:
```bash
bun run test           # or: bun test
```

### After Convex changes:
```bash
bunx convex dev        # check for schema/function errors
```

### After Supabase changes:
- Check migrations applied correctly
- Verify types generated with `generate_typescript_types`

### After UI changes:
- Use `agent-browser` skill to visually verify
- Run `/rams` command for accessibility check

### Fix loop:
```
1. Run `bunx tsc --noEmit && bunx ultracite check`
2. If errors → fix them
3. Re-run until passing
4. Only then say "done"
```

**Rule: Never deliver code without running `bunx tsc --noEmit && bunx ultracite check`. If errors, fix them.**
