---
description: Prisma ORM commands and patterns
---

Prisma development helper.

## Commands

```bash
# Generate client
bunx prisma generate

# Create migration
bunx prisma migrate dev --name add_users

# Apply migrations (production)
bunx prisma migrate deploy

# Reset database
bunx prisma migrate reset

# Open Studio
bunx prisma studio

# Format schema
bunx prisma format
```

## Schema Example

```prisma
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String?
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  createdAt DateTime @default(now())
}
```

## Client Usage

```typescript
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

// Find many
const users = await prisma.user.findMany({
  where: { email: { contains: '@example.com' } },
  include: { posts: true }
})

// Create
const user = await prisma.user.create({
  data: { email: 'john@example.com', name: 'John' }
})

// Update
await prisma.user.update({
  where: { id: '123' },
  data: { name: 'Jane' }
})

// Delete
await prisma.user.delete({
  where: { id: '123' }
})

// Transaction
await prisma.$transaction([
  prisma.user.create({ data: { ... } }),
  prisma.post.create({ data: { ... } })
])
```
