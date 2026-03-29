---
description: Next.js specific commands and patterns
---

Next.js development helper.

## Quick Commands

```bash
# Dev server
bun run dev

# Build
bun run build

# Start production
bun run start

# Lint
bun run lint
```

## File Conventions

| File | Purpose |
|------|---------|
| `page.tsx` | Route page |
| `layout.tsx` | Shared layout |
| `loading.tsx` | Loading UI |
| `error.tsx` | Error boundary |
| `not-found.tsx` | 404 page |
| `route.ts` | API route |

## App Router Structure

```
app/
├── layout.tsx        # Root layout
├── page.tsx          # Home page
├── globals.css
├── api/
│   └── users/
│       └── route.ts  # /api/users
├── dashboard/
│   ├── layout.tsx    # Dashboard layout
│   └── page.tsx      # /dashboard
└── [id]/
    └── page.tsx      # Dynamic route
```

## Common Patterns

### Server Component (default)
```tsx
async function Page() {
  const data = await fetchData()
  return <div>{data}</div>
}
```

### Client Component
```tsx
'use client'
import { useState } from 'react'
```

### API Route
```ts
import { NextResponse } from 'next/server'

export async function GET() {
  return NextResponse.json({ data: 'value' })
}
```

### Metadata
```tsx
export const metadata = {
  title: 'Page Title',
  description: 'Description'
}
```

## Performance Tips

- Use Server Components by default
- Add `loading.tsx` for suspense
- Use `next/image` for images
- Use `next/link` for navigation
- Implement ISR for dynamic content
