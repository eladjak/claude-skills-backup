---
description: Resend email integration patterns
---

Resend email helper.

## Setup

```bash
bun add resend
```

## Basic Usage

```typescript
// lib/resend.ts
import { Resend } from 'resend'

export const resend = new Resend(process.env.RESEND_API_KEY)
```

## Send Email

```typescript
// app/api/send/route.ts
import { resend } from '@/lib/resend'

export async function POST(request: Request) {
  const { to, subject, html } = await request.json()

  const { data, error } = await resend.emails.send({
    from: 'noreply@yourdomain.com',
    to,
    subject,
    html
  })

  if (error) {
    return Response.json({ error }, { status: 400 })
  }

  return Response.json({ id: data?.id })
}
```

## React Email Templates

```bash
bun add @react-email/components
```

```tsx
// emails/welcome.tsx
import { Html, Head, Body, Container, Text, Button } from '@react-email/components'

interface WelcomeEmailProps {
  name: string
  url: string
}

export function WelcomeEmail({ name, url }: WelcomeEmailProps) {
  return (
    <Html>
      <Head />
      <Body style={{ fontFamily: 'sans-serif' }}>
        <Container>
          <Text>Welcome, {name}!</Text>
          <Button href={url}>Get Started</Button>
        </Container>
      </Body>
    </Html>
  )
}
```

## Send with Template

```typescript
import { WelcomeEmail } from '@/emails/welcome'

await resend.emails.send({
  from: 'welcome@yourdomain.com',
  to: user.email,
  subject: 'Welcome!',
  react: WelcomeEmail({ name: user.name, url: 'https://app.example.com' })
})
```

## Batch Send

```typescript
await resend.batch.send([
  {
    from: 'noreply@yourdomain.com',
    to: 'user1@example.com',
    subject: 'Hello',
    html: '<p>Hello!</p>'
  },
  {
    from: 'noreply@yourdomain.com',
    to: 'user2@example.com',
    subject: 'Hello',
    html: '<p>Hello!</p>'
  }
])
```

## Preview Emails

```bash
# Run email preview server
bunx email dev
```
