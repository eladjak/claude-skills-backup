---
description: Clerk authentication patterns
---

Clerk authentication helper.

## Setup

```bash
bun add @clerk/nextjs
```

## Environment

```env
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_xxx
CLERK_SECRET_KEY=sk_xxx
NEXT_PUBLIC_CLERK_SIGN_IN_URL=/sign-in
NEXT_PUBLIC_CLERK_SIGN_UP_URL=/sign-up
```

## Provider

```tsx
// app/layout.tsx
import { ClerkProvider } from '@clerk/nextjs'

export default function RootLayout({ children }) {
  return (
    <ClerkProvider>
      <html>
        <body>{children}</body>
      </html>
    </ClerkProvider>
  )
}
```

## Middleware

```typescript
// middleware.ts
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'

const isPublicRoute = createRouteMatcher([
  '/',
  '/sign-in(.*)',
  '/sign-up(.*)',
  '/api/webhooks(.*)'
])

export default clerkMiddleware((auth, req) => {
  if (!isPublicRoute(req)) {
    auth().protect()
  }
})

export const config = {
  matcher: ['/((?!.*\\..*|_next).*)', '/', '/(api|trpc)(.*)']
}
```

## Components

```tsx
import {
  SignInButton,
  SignUpButton,
  SignOutButton,
  SignedIn,
  SignedOut,
  UserButton
} from '@clerk/nextjs'

function Header() {
  return (
    <header>
      <SignedIn>
        <UserButton afterSignOutUrl="/" />
      </SignedIn>
      <SignedOut>
        <SignInButton mode="modal" />
        <SignUpButton mode="modal" />
      </SignedOut>
    </header>
  )
}
```

## Server-side

```typescript
// app/api/user/route.ts
import { auth, currentUser } from '@clerk/nextjs/server'

export async function GET() {
  const { userId } = auth()
  if (!userId) {
    return new Response('Unauthorized', { status: 401 })
  }

  const user = await currentUser()
  return Response.json(user)
}
```

## Client-side

```tsx
'use client'
import { useUser, useAuth } from '@clerk/nextjs'

function Profile() {
  const { user, isLoaded } = useUser()
  const { signOut, getToken } = useAuth()

  if (!isLoaded) return <Loading />

  return (
    <div>
      <p>Welcome, {user?.firstName}</p>
      <button onClick={() => signOut()}>Sign out</button>
    </div>
  )
}
```

## Webhooks

```typescript
// app/api/webhooks/clerk/route.ts
import { Webhook } from 'svix'
import { headers } from 'next/headers'

export async function POST(req: Request) {
  const payload = await req.text()
  const headersList = headers()

  const wh = new Webhook(process.env.CLERK_WEBHOOK_SECRET!)
  const evt = wh.verify(payload, {
    'svix-id': headersList.get('svix-id')!,
    'svix-timestamp': headersList.get('svix-timestamp')!,
    'svix-signature': headersList.get('svix-signature')!
  })

  if (evt.type === 'user.created') {
    // Create user in database
  }

  return Response.json({ received: true })
}
```
