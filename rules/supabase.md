---
paths:
  - "**/supabase/**"
  - "supabase/**"
  - "**/supabase.ts"
  - "**/supabaseClient.ts"
---

# Supabase Backend

Use Supabase MCP when working with Supabase projects. Supabase includes built-in auth (no Better Auth needed).

## Supabase MCP Tools

### Database
| Tool | Purpose |
|------|---------|
| `list_tables` | List all tables within specified schemas |
| `list_extensions` | List all extensions in the database |
| `list_migrations` | List all migrations in the database |
| `apply_migration` | Apply SQL migration (DDL operations, schema changes) |
| `execute_sql` | Execute raw SQL (regular queries, not schema changes) |

### Knowledge Base
| Tool | Purpose |
|------|---------|
| `search_docs` | Search Supabase documentation |

### Development
| Tool | Purpose |
|------|---------|
| `get_project_url` | Get API URL for a project |
| `get_publishable_keys` | Get anonymous API keys (client-safe) |
| `generate_typescript_types` | Generate TypeScript types from schema |

### Edge Functions
| Tool | Purpose |
|------|---------|
| `list_edge_functions` | List all Edge Functions |
| `get_edge_function` | Get file contents for an Edge Function |
| `deploy_edge_function` | Deploy new or update Edge Function |

### Debugging
| Tool | Purpose |
|------|---------|
| `get_logs` | Get logs by service (api, postgres, edge functions, auth, storage, realtime) |
| `get_advisors` | Get advisory notices (security, performance issues) |

### Storage
| Tool | Purpose |
|------|---------|
| `list_storage_buckets` | List all storage buckets |
| `get_storage_config` | Get storage config |
| `update_storage_config` | Update storage config (paid plan) |

### Branching (Paid Plan)
| Tool | Purpose |
|------|---------|
| `create_branch` | Create development branch with migrations |
| `list_branches` | List all development branches |
| `delete_branch` | Delete a development branch |
| `merge_branch` | Merge migrations and edge functions to production |
| `reset_branch` | Reset migrations to prior version |
| `rebase_branch` | Rebase on production to handle drift |

### Account (when no project_ref set)
| Tool | Purpose |
|------|---------|
| `list_projects` | List all Supabase projects |
| `get_project` | Get project details |
| `create_project` | Create new Supabase project |
| `pause_project` | Pause a project |
| `restore_project` | Restore a project |
| `list_organizations` | List all organizations |
| `get_organization` | Get organization details |

## Supabase Workflow

```
1. list_tables            → See schema structure
2. execute_sql            → Query data (SELECT)
3. apply_migration        → Make schema changes (DDL)
4. generate_typescript_types → Update types after schema changes
5. get_logs               → Debug issues
```

## Best Practices

- Use `apply_migration` for DDL (CREATE, ALTER, DROP)
- Use `execute_sql` for DML (SELECT, INSERT, UPDATE, DELETE)
- Always `generate_typescript_types` after schema changes
- Use `read_only=true` mode for safety when just exploring
- Scope to specific project with `project_ref`

## Authentication

Supabase has built-in auth - **do NOT use Better Auth with Supabase**.

Use Supabase Auth:
- Email/password, magic link, phone
- OAuth providers (Google, GitHub, etc.)
- Row Level Security (RLS) policies

## Dev Commands

```bash
bunx supabase start       # Start local dev
bunx supabase db push     # Push migrations
bunx supabase gen types   # Generate TypeScript types
bunx supabase functions serve  # Serve edge functions locally
```
