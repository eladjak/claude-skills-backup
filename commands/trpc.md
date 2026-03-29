---
description: tRPC type-safe API patterns
---

tRPC development helper.

## Setup

```bash
bun add @trpc/server @trpc/client @trpc/react-query @tanstack/react-query zod
```

## Server Setup

```typescript
// server/trpc.ts
import { initTRPC, TRPCError } from '@trpc/server'
import { z } from 'zod'

const t = initTRPC.context<Context>().create()

export const router = t.router
export const publicProcedure = t.procedure

// Protected procedure
export const protectedProcedure = t.procedure.use(({ ctx, next }) => {
  if (!ctx.user) {
    throw new TRPCError({ code: 'UNAUTHORIZED' })
  }
  return next({ ctx: { user: ctx.user } })
})
```

## Router

```typescript
// server/routers/user.ts
export const userRouter = router({
  getById: publicProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input }) => {
      return await db.user.findUnique({ where: { id: input.id } })
    }),

  create: protectedProcedure
    .input(z.object({
      name: z.string(),
      email: z.string().email()
    }))
    .mutation(async ({ input }) => {
      return await db.user.create({ data: input })
    })
})

// server/routers/_app.ts
export const appRouter = router({
  user: userRouter,
  post: postRouter
})

export type AppRouter = typeof appRouter
```

## Client Usage (React)

```tsx
// utils/trpc.ts
import { createTRPCReact } from '@trpc/react-query'
import type { AppRouter } from '@/server/routers/_app'

export const trpc = createTRPCReact<AppRouter>()

// Component
function UserProfile({ id }: { id: string }) {
  const { data, isLoading } = trpc.user.getById.useQuery({ id })

  const createUser = trpc.user.create.useMutation({
    onSuccess: () => {
      utils.user.getById.invalidate()
    }
  })

  if (isLoading) return <Loading />
  return <div>{data?.name}</div>
}
```

## Error Handling

```typescript
import { TRPCError } from '@trpc/server'

throw new TRPCError({
  code: 'NOT_FOUND',
  message: 'User not found'
})

// Codes: UNAUTHORIZED, FORBIDDEN, NOT_FOUND, BAD_REQUEST, INTERNAL_SERVER_ERROR
```
