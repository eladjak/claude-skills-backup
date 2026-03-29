---
description: Zod schema validation patterns
---

Zod validation helper.

## Basic Types

```typescript
import { z } from 'zod'

// Primitives
z.string()
z.number()
z.boolean()
z.date()
z.undefined()
z.null()
z.any()
z.unknown()

// Literals
z.literal('active')
z.literal(42)
```

## String Validations

```typescript
z.string().min(1, 'Required')
z.string().max(100)
z.string().length(5)
z.string().email('Invalid email')
z.string().url()
z.string().uuid()
z.string().regex(/^[a-z]+$/)
z.string().startsWith('https://')
z.string().trim()
z.string().toLowerCase()
```

## Number Validations

```typescript
z.number().int()
z.number().positive()
z.number().negative()
z.number().min(0)
z.number().max(100)
z.number().finite()

// Coerce from string
z.coerce.number()
```

## Objects

```typescript
const UserSchema = z.object({
  name: z.string(),
  email: z.string().email(),
  age: z.number().optional(),
  role: z.enum(['admin', 'user']).default('user')
})

type User = z.infer<typeof UserSchema>

// Extend
const AdminSchema = UserSchema.extend({
  permissions: z.array(z.string())
})

// Pick/Omit
const PublicUser = UserSchema.pick({ name: true, email: true })
const UserInput = UserSchema.omit({ role: true })

// Partial
const UpdateUser = UserSchema.partial()
```

## Arrays

```typescript
z.array(z.string())
z.array(z.number()).min(1).max(10)
z.string().array() // Same as above

// Tuple
z.tuple([z.string(), z.number()])
```

## Unions & Enums

```typescript
// Union
z.union([z.string(), z.number()])
z.string().or(z.number())

// Discriminated union
const ResultSchema = z.discriminatedUnion('status', [
  z.object({ status: z.literal('success'), data: z.any() }),
  z.object({ status: z.literal('error'), message: z.string() })
])

// Enum
z.enum(['pending', 'active', 'done'])
```

## Validation

```typescript
// Parse (throws on error)
const user = UserSchema.parse(input)

// Safe parse (returns result)
const result = UserSchema.safeParse(input)
if (result.success) {
  console.log(result.data)
} else {
  console.log(result.error.flatten())
}
```

## Transforms

```typescript
const schema = z.string().transform(val => val.toUpperCase())

const dateSchema = z.string().transform(val => new Date(val))

const schema = z.object({
  name: z.string()
}).transform(data => ({
  ...data,
  createdAt: new Date()
}))
```
