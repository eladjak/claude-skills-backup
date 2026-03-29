# Smart Patterns (from Claude Code Mastery - Guy Aga)

## 1. Self-Healing Skills

Every skill.md MUST include an Error Handling Policies section:

```markdown
## Error Handling Policies
- **403/429 blocked**: Wait 30s, retry with fallback method
- **Empty result**: Check for alternative selectors/paths before failing
- **Timeout**: Retry once with doubled timeout, then report
- **Missing dependency**: Auto-install with `bun add` before retrying
```

This gives Claude permission to fix problems autonomously without asking every time.

## 2. Preview Before Mass Operations

Before creating/modifying multiple files, ALWAYS:
1. Generate ONE preview first
2. Show/verify it looks correct
3. Only then proceed with the rest

```
BAD:  "Generate 50 pages" → gets 50 bad pages
GOOD: "Generate 1 preview page" → verify → "Generate remaining 49"
```

## 3. Context Bloat Awareness

- Each loaded MCP server adds tokens to EVERY request
- Each rule file in `~/.claude/rules/` is loaded into context
- MEMORY.md is loaded into every conversation
- **Keep MEMORY.md under 2,000 words** - use topic files for details
- **Periodically ask**: "Summarize and clean my memory file"
- Only load MCPs you actually need (use ToolSearch, not preload all)

## 4. Sub-Agent Decision Tree

```
Need the task done? Ask:
├── Does it need chat history? → Do it in main chat
├── Is it trivial (< 30 seconds)? → Do it in main chat
├── Is it research/review? → Use sub-agent (clean slate = objective)
├── Is it code review? → ALWAYS sub-agent (no confirmation bias)
└── Is it multi-step complex? → Sub-agent with clear skill.md
```

Key insight: Sub-agent code reviewers are MORE objective because they don't have the bias of having written the code.

## 5. One-Shot Skill Creation

When building a new skill, give Claude ONE detailed request with:
- Example data/screenshot
- Specific libraries to use (not generic)
- Clear success criteria ("output file must be > 0 bytes")
- Folder structure to create

```
"Build a skill called X. Create .claude/skills/X/ with skill.md and scripts/.
Use [specific library]. Trigger on [words]. Steps: 1... 2... 3..."
```

## 6. Skill Success Criteria

ALWAYS define what "done" means in skill.md:

```markdown
## Success Criteria
- Output file exists and is > 0 bytes
- No error messages in stdout
- Result matches expected format (JSON/CSV/HTML)
```

Without this, Claude may accept empty results as valid.
