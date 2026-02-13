---
paths:
  - "**/convex/**"
  - "convex/**"
  - "**/convex.json"
---

# Convex Backend

Use these skills and MCP when working with Convex projects.

## Skills (Load as Needed)

| Skill | When to Use |
|-------|-------------|
| `Convex Best Practices` | General patterns, function organization, TypeScript |
| `Convex Functions` | Writing queries, mutations, actions, HTTP actions |
| `Convex Schema Validator` | Database schema, typing, indexes, migrations |
| `Convex Realtime` | Subscriptions, optimistic updates, pagination |
| `Convex File Storage` | File upload, serving, deletion |
| `Convex HTTP Actions` | External API integration, webhooks |
| `Convex Cron Jobs` | Scheduled functions, background tasks |
| `Convex Agents` | Building AI agents with Convex |
| `Convex Security Check` | Quick security audit checklist |
| `Convex Security Audit` | Deep security review |
| `Convex Migrations` | Schema migration strategies |
| `Convex Component Authoring` | Creating reusable Convex components |

## Convex MCP Tools

| Tool | Purpose |
|------|---------|
| `status` | Get deployment selector (run FIRST) |
| `tables` | List tables with declared + inferred schemas |
| `data` | Paginate through documents in a table |
| `runOneoffQuery` | Execute sandboxed JS queries (read-only, safe) |
| `functionSpec` | Get all deployed functions metadata |
| `run` | Execute deployed Convex functions |
| `logs` | Fetch function execution logs |
| `envList/envGet/envSet/envRemove` | Manage environment variables |

## Convex Workflow

```
1. status         → Get deployment selector
2. tables         → See schema structure
3. functionSpec   → See available functions
4. runOneoffQuery → Query data with JS (safe, sandboxed)
5. run            → Execute actual functions
```

## Authentication

For Convex projects, use **Better Auth** for authentication:
- `better-auth-best-practices` skill
- `create-auth-skill` skill
- `/providers` command (list auth providers)
- `/explain-error` command (debug auth errors)

## Dev Commands

```bash
bunx convex dev        # Start dev server
bunx convex deploy     # Deploy to production
```
