---
description: Database and code migration helpers
---

Migration helper.

## Database Migrations

### Create Migration
```bash
# Supabase
supabase migration new add_users_table

# Creates: supabase/migrations/TIMESTAMP_add_users_table.sql
```

### Write Migration
```sql
-- Up migration
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);

-- Down migration (in separate file or comment)
-- DROP TABLE users;
```

### Apply Migration
```bash
# Supabase local
supabase db reset

# Supabase remote
supabase db push

# Direct SQL
psql $DATABASE_URL < migration.sql
```

## Safe Migration Patterns

### Add Column
```sql
-- Safe: nullable column
ALTER TABLE users ADD COLUMN phone TEXT;

-- Then backfill
UPDATE users SET phone = '' WHERE phone IS NULL;

-- Then add constraint
ALTER TABLE users ALTER COLUMN phone SET NOT NULL;
```

### Rename Column
```sql
-- Step 1: Add new column
ALTER TABLE users ADD COLUMN full_name TEXT;

-- Step 2: Copy data
UPDATE users SET full_name = name;

-- Step 3: Update app to use both
-- Step 4: Drop old column
ALTER TABLE users DROP COLUMN name;
```

### Add Index (non-blocking)
```sql
-- PostgreSQL
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
```

## Code Migrations

### Find & Replace
```bash
# Find all occurrences
Grep: "oldFunction"

# Replace with LSP rename
# Or use sed for simple cases
```

### Deprecation Pattern
```typescript
/** @deprecated Use newFunction instead */
function oldFunction() {
  console.warn('oldFunction is deprecated')
  return newFunction()
}
```

## Checklist

- [ ] Backup database before migration
- [ ] Test migration on staging
- [ ] Plan rollback strategy
- [ ] Run during low-traffic period
- [ ] Monitor after deployment
- [ ] Update types/schemas
- [ ] Update documentation
