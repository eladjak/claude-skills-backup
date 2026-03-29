---
description: API development and testing
---

API development helper.

## Testing Endpoints

### GET
```bash
curl -s http://localhost:3000/api/users | jq
```

### POST
```bash
curl -s -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com"}' | jq
```

### PUT
```bash
curl -s -X PUT http://localhost:3000/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "Jane"}' | jq
```

### DELETE
```bash
curl -s -X DELETE http://localhost:3000/api/users/1 | jq
```

### With Auth
```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  http://localhost:3000/api/protected | jq
```

## Response Format

### Success
```json
{
  "success": true,
  "data": { ... },
  "meta": { "total": 100, "page": 1 }
}
```

### Error
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required"
  }
}
```

## Status Codes

| Code | Meaning | Use |
|------|---------|-----|
| 200 | OK | Successful GET/PUT |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Missing auth |
| 403 | Forbidden | No permission |
| 404 | Not Found | Resource missing |
| 422 | Unprocessable | Validation failed |
| 500 | Server Error | Internal error |

## Validation

```typescript
import { z } from 'zod'

const UserSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  age: z.number().int().positive().optional()
})

const validated = UserSchema.parse(input)
```
