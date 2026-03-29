---
description: Redis caching and data patterns
---

Redis development helper.

## Upstash Redis (Serverless)

```bash
bun add @upstash/redis
```

```typescript
import { Redis } from '@upstash/redis'

const redis = Redis.fromEnv()
// or
const redis = new Redis({
  url: process.env.UPSTASH_REDIS_URL,
  token: process.env.UPSTASH_REDIS_TOKEN
})
```

## Basic Operations

```typescript
// String
await redis.set('key', 'value')
await redis.set('key', 'value', { ex: 60 }) // Expire in 60s
const value = await redis.get('key')

// Delete
await redis.del('key')

// Check exists
const exists = await redis.exists('key')

// Increment
await redis.incr('counter')
await redis.incrby('counter', 5)
```

## JSON Data

```typescript
// Store object
await redis.set('user:123', JSON.stringify({ name: 'John', email: 'john@example.com' }))

// Retrieve
const user = await redis.get<{ name: string; email: string }>('user:123')
```

## Hash Operations

```typescript
// Set hash fields
await redis.hset('user:123', {
  name: 'John',
  email: 'john@example.com'
})

// Get all fields
const user = await redis.hgetall('user:123')

// Get specific field
const name = await redis.hget('user:123', 'name')
```

## Lists

```typescript
// Add to list
await redis.lpush('queue', 'item1', 'item2')
await redis.rpush('queue', 'item3')

// Get from list
const item = await redis.lpop('queue')
const items = await redis.lrange('queue', 0, -1)
```

## Sets

```typescript
// Add to set
await redis.sadd('tags', 'react', 'typescript', 'nextjs')

// Check membership
const isMember = await redis.sismember('tags', 'react')

// Get all members
const tags = await redis.smembers('tags')
```

## Caching Pattern

```typescript
async function getCachedData<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttl = 60
): Promise<T> {
  // Try cache first
  const cached = await redis.get<T>(key)
  if (cached) return cached

  // Fetch fresh data
  const data = await fetcher()

  // Cache it
  await redis.set(key, data, { ex: ttl })

  return data
}

// Usage
const users = await getCachedData('users', () => db.users.findMany(), 300)
```

## Rate Limiting

```typescript
import { Ratelimit } from '@upstash/ratelimit'

const ratelimit = new Ratelimit({
  redis,
  limiter: Ratelimit.slidingWindow(10, '10 s')
})

const { success, limit, remaining } = await ratelimit.limit(userId)
if (!success) {
  return new Response('Too many requests', { status: 429 })
}
```
