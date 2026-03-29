---
description: Form handling patterns
---

Form development helper.

## React Hook Form + Zod

### Setup
```bash
bun add react-hook-form @hookform/resolvers zod
```

### Schema
```typescript
import { z } from 'zod'

const formSchema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Min 8 characters'),
  age: z.coerce.number().int().positive().optional()
})

type FormData = z.infer<typeof formSchema>
```

### Form Component
```tsx
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'

function LoginForm() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting }
  } = useForm<FormData>({
    resolver: zodResolver(formSchema)
  })

  const onSubmit = async (data: FormData) => {
    await login(data)
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} placeholder="Email" />
      {errors.email && <span>{errors.email.message}</span>}

      <input {...register('password')} type="password" />
      {errors.password && <span>{errors.password.message}</span>}

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Loading...' : 'Submit'}
      </button>
    </form>
  )
}
```

## Server Actions (Next.js)

```typescript
'use server'

import { z } from 'zod'

const schema = z.object({
  email: z.string().email()
})

export async function submitForm(formData: FormData) {
  const result = schema.safeParse({
    email: formData.get('email')
  })

  if (!result.success) {
    return { error: result.error.flatten() }
  }

  // Process data
  return { success: true }
}
```

## Validation Patterns

```typescript
// Email
z.string().email()

// Password
z.string().min(8).regex(/[A-Z]/, 'Need uppercase')

// Phone
z.string().regex(/^\+?[1-9]\d{1,14}$/)

// URL
z.string().url()

// Date
z.coerce.date()

// Enum
z.enum(['admin', 'user', 'guest'])

// Optional with default
z.string().optional().default('')

// Conditional
z.object({
  type: z.enum(['email', 'phone']),
  value: z.string()
}).refine(data => {
  if (data.type === 'email') return data.value.includes('@')
  return data.value.length >= 10
})
```
