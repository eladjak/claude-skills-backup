# Documentation MCPs (Overcome Knowledge Cutoff)

**IMPORTANT:** AI knowledge is cut off. Use these MCPs for current docs and real code.

## Best Combo: Context7 + Octocode (USE TOGETHER)

**Context7** = Official docs, API reference
**Octocode** = Real implementations from production codebases

**Together = Docs + Real patterns = Best understanding**

## Context7 - Library Documentation

| Tool | Purpose |
|------|---------|
| `mcp__context7__resolve-library-id` | Find Context7 library ID |
| `mcp__context7__query-docs` | Get up-to-date docs for a library |

## Octocode - Real Code Search (USE OFTEN!)

| Tool | Purpose |
|------|---------|
| `mcp__octocode__githubSearchCode` | Search real implementations across GitHub |
| `mcp__octocode__githubGetFileContent` | Read actual code from repos |
| `mcp__octocode__githubViewRepoStructure` | View repo structure |
| `mcp__octocode__githubSearchRepositories` | Find repos using a library |
| `mcp__octocode__githubSearchPullRequests` | Search PRs for patterns |
| `mcp__octocode__packageSearch` | Search npm/Python packages |

**Octocode workflow:**
1. Find repos using the library → `githubSearchRepositories`
2. Search for specific patterns → `githubSearchCode`
3. Read actual implementations → `githubGetFileContent`

## DeepWiki - GitHub Repo Documentation (Backup)

| Tool | Purpose |
|------|---------|
| `mcp__deepwiki__read_wiki_structure` | Get doc topics for a GitHub repo |
| `mcp__deepwiki__read_wiki_contents` | View documentation for a repo |
| `mcp__deepwiki__ask_question` | Ask AI-powered questions about a repo |

## Research Workflow

```
1. Context7 → Get official API docs
2. Octocode → Find real implementations using that API
3. DeepWiki → If need more context on a specific repo
```

## WebSearch / WebFetch (Fallback)

| Tool | When to Use |
|------|-------------|
| `WebSearch` | When Context7/DeepWiki don't have current info |
| `WebFetch` | Fetch specific documentation URLs |

## Error Recovery

### If Context7/DeepWiki don't have docs:
1. Try Octocode to search GitHub
2. Use WebSearch for latest docs
3. Use WebFetch on official documentation URL
4. Check package README on npm/GitHub

**Rule: Always use Context7 + Octocode together. Docs alone aren't enough - see real usage!**
