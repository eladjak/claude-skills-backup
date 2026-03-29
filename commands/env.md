---
description: Manage environment variables
---

Work with environment variables safely.

## Check .env Files

```bash
ls -la .env* 2>/dev/null
```

## Verify .gitignore

```
Grep(pattern="\\.env", path=".gitignore")
```

## Template .env.example

Create a template without real values:
```
Read: .env
# Remove actual values, keep structure
Write: .env.example
```

## Common Variables

### Database
```
DATABASE_URL=
POSTGRES_PASSWORD=
```

### API Keys
```
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
```

### Auth
```
JWT_SECRET=
SESSION_SECRET=
```

### Services
```
SUPABASE_URL=
SUPABASE_ANON_KEY=
CONVEX_URL=
```

## Security Rules

- NEVER commit .env files
- ALWAYS have .env in .gitignore
- Use .env.example for templates
- Rotate exposed secrets immediately
- Use different values per environment

## Validation

```typescript
// Validate required env vars
const required = ['DATABASE_URL', 'API_KEY']
for (const key of required) {
  if (!process.env[key]) {
    throw new Error(`Missing ${key}`)
  }
}
```
