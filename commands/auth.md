---
description: Authentication setup and patterns
---

Authentication helper.

## Better Auth (Recommended)

### Setup
```bash
bun add better-auth
```

### Configuration
```typescript
// lib/auth.ts
import { betterAuth } from 'better-auth'

export const auth = betterAuth({
  database: {
    type: 'postgres',
    url: process.env.DATABASE_URL
  },
  emailAndPassword: {
    enabled: true
  },
  socialProviders: {
    google: {
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!
    }
  }
})
```

### Client
```typescript
import { createAuthClient } from 'better-auth/client'

export const authClient = createAuthClient()

// Sign up
await authClient.signUp.email({
  email: 'user@example.com',
  password: 'password123',
  name: 'John Doe'
})

// Sign in
await authClient.signIn.email({
  email: 'user@example.com',
  password: 'password123'
})

// Sign out
await authClient.signOut()

// Get session
const session = await authClient.getSession()
```

## Supabase Auth

```typescript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(url, key)

// Sign up
await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'password123'
})

// Sign in
await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'password123'
})

// OAuth
await supabase.auth.signInWithOAuth({
  provider: 'google'
})

// Get user
const { data: { user } } = await supabase.auth.getUser()
```

## Protected Routes (Next.js)

```typescript
// middleware.ts
import { auth } from '@/lib/auth'

export default auth((req) => {
  if (!req.auth && req.nextUrl.pathname.startsWith('/dashboard')) {
    return Response.redirect(new URL('/login', req.url))
  }
})

export const config = {
  matcher: ['/dashboard/:path*']
}
```

## Session Handling

```typescript
// Server component
const session = await auth()
if (!session) redirect('/login')

// Client component
const { data: session } = useSession()
```
