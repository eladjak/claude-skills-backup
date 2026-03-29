---
description: Monitoring and observability
---

Monitoring helper.

## Error Tracking (Sentry)

### Setup
```bash
bun add @sentry/nextjs
```

### Configuration
```typescript
// sentry.client.config.ts
import * as Sentry from '@sentry/nextjs'

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 0.1,
  environment: process.env.NODE_ENV
})
```

### Usage
```typescript
try {
  await riskyOperation()
} catch (error) {
  Sentry.captureException(error)
  throw error
}

// Add context
Sentry.setUser({ id: user.id, email: user.email })
Sentry.setTag('feature', 'checkout')
```

## Logging

### Structured Logging
```typescript
const log = {
  info: (msg: string, data?: object) =>
    console.log(JSON.stringify({ level: 'info', msg, ...data, ts: Date.now() })),
  error: (msg: string, error?: Error, data?: object) =>
    console.error(JSON.stringify({
      level: 'error', msg, error: error?.message, stack: error?.stack, ...data, ts: Date.now()
    }))
}

log.info('User logged in', { userId: '123' })
log.error('Payment failed', error, { orderId: '456' })
```

## Analytics

### Vercel Analytics
```tsx
import { Analytics } from '@vercel/analytics/react'

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
      </body>
    </html>
  )
}
```

### Custom Events
```typescript
import { track } from '@vercel/analytics'

track('button_clicked', { button: 'signup' })
track('purchase', { amount: 99.99, currency: 'USD' })
```

## Health Checks

```typescript
// /api/health/route.ts
export async function GET() {
  const checks = {
    database: await checkDatabase(),
    redis: await checkRedis(),
    external: await checkExternalAPI()
  }

  const healthy = Object.values(checks).every(c => c.ok)

  return Response.json(
    { status: healthy ? 'healthy' : 'unhealthy', checks },
    { status: healthy ? 200 : 503 }
  )
}
```

## Performance Monitoring

```typescript
// Measure async operation
const start = performance.now()
await operation()
const duration = performance.now() - start

log.info('Operation completed', { duration, operation: 'fetchUsers' })
```

## Alerts

```typescript
// Simple alert function
async function alert(message: string, severity: 'low' | 'medium' | 'high') {
  if (severity === 'high') {
    await sendSlackMessage('#alerts', `🚨 ${message}`)
  }
  log.error(message, undefined, { severity })
}
```
