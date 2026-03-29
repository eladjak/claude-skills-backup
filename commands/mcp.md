---
description: List and search MCP tools
---

Discover and use MCP (Model Context Protocol) tools.

## Key MCPs

### Documentation
| MCP | Tools | Purpose |
|-----|-------|---------|
| `context7` | resolve-library-id, query-docs | Official library docs |
| `octocode` | githubSearchCode, githubGetFileContent | Real code examples |
| `deepwiki` | read_wiki_structure, ask_question | GitHub repo docs |

### Databases
| MCP | Tools | Purpose |
|-----|-------|---------|
| `supabase` | execute_sql, generate_typescript_types | Supabase operations |
| `convex` | Various | Convex backend |

### Services
| MCP | Tools | Purpose |
|-----|-------|---------|
| `ultracite` | get_rules, check, fix | Linting |

## Usage

### Load MCP Tool
```
ToolSearch(query="select:mcp__context7__query-docs")
```

### Search for MCPs
```
ToolSearch(query="supabase")
```

## Best Practice: Context7 + Octocode

For any unfamiliar API:
1. `context7` → Get official docs
2. `octocode` → Find real implementations
3. Combine knowledge → Write correct code

## Common Workflows

### Research a Library
```
1. mcp__context7__resolve-library-id → Get ID
2. mcp__context7__query-docs → Get docs
3. mcp__octocode__githubSearchCode → Real examples
```

### Database Operations
```
1. mcp__supabase__execute_sql → Run query
2. mcp__supabase__generate_typescript_types → Update types
```
