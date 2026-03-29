---
description: Database operations and patterns
---

Database development helper.

## Supabase

### Quick Commands
```sql
-- List tables
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';

-- Describe table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'users';
```

### Client Usage
```typescript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(url, key)

// Select
const { data } = await supabase
  .from('users')
  .select('*')
  .eq('status', 'active')

// Insert
await supabase.from('users').insert({ name: 'John' })

// Update
await supabase.from('users').update({ name: 'Jane' }).eq('id', 1)

// Delete
await supabase.from('users').delete().eq('id', 1)
```

## Convex

### Schema
```typescript
import { defineSchema, defineTable } from 'convex/server'
import { v } from 'convex/values'

export default defineSchema({
  users: defineTable({
    name: v.string(),
    email: v.string(),
  }).index('by_email', ['email'])
})
```

### Query
```typescript
export const list = query({
  handler: async (ctx) => {
    return await ctx.db.query('users').collect()
  }
})
```

### Mutation
```typescript
export const create = mutation({
  args: { name: v.string() },
  handler: async (ctx, args) => {
    return await ctx.db.insert('users', { name: args.name })
  }
})
```

## Common Patterns

### Pagination
```typescript
const { data } = await supabase
  .from('posts')
  .select('*')
  .range(0, 9)  // First 10 items
  .order('created_at', { ascending: false })
```

### Transactions
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

### Indexes
```sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at DESC);
```
