---
description: Drizzle ORM commands and patterns
---

Drizzle development helper.

## Setup

```bash
bun add drizzle-orm postgres
bun add -d drizzle-kit
```

## Schema

```typescript
// db/schema.ts
import { pgTable, text, timestamp, uuid, boolean } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').notNull().unique(),
  name: text('name'),
  createdAt: timestamp('created_at').defaultNow()
})

export const posts = pgTable('posts', {
  id: uuid('id').primaryKey().defaultRandom(),
  title: text('title').notNull(),
  content: text('content'),
  published: boolean('published').default(false),
  authorId: uuid('author_id').references(() => users.id),
  createdAt: timestamp('created_at').defaultNow()
})
```

## Client

```typescript
// db/index.ts
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import * as schema from './schema'

const client = postgres(process.env.DATABASE_URL!)
export const db = drizzle(client, { schema })
```

## Queries

```typescript
import { eq, and, like, desc } from 'drizzle-orm'

// Select
const allUsers = await db.select().from(users)

const user = await db.select()
  .from(users)
  .where(eq(users.id, '123'))
  .limit(1)

// With relations
const usersWithPosts = await db.query.users.findMany({
  with: { posts: true }
})

// Insert
await db.insert(users).values({
  email: 'john@example.com',
  name: 'John'
})

// Update
await db.update(users)
  .set({ name: 'Jane' })
  .where(eq(users.id, '123'))

// Delete
await db.delete(users).where(eq(users.id, '123'))
```

## Commands

```bash
# Generate migrations
bunx drizzle-kit generate

# Apply migrations
bunx drizzle-kit migrate

# Open Studio
bunx drizzle-kit studio

# Push schema (no migration)
bunx drizzle-kit push
```

## Config

```typescript
// drizzle.config.ts
import { defineConfig } from 'drizzle-kit'

export default defineConfig({
  schema: './db/schema.ts',
  out: './drizzle',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL!
  }
})
```
