---
description: Security audit and vulnerability check
---

Check for security vulnerabilities.

## Checklist

### Input Validation
- [ ] All user inputs sanitized
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS prevented (escaped output)
- [ ] Path traversal blocked

### Authentication
- [ ] Passwords hashed (bcrypt/argon2)
- [ ] Sessions secure (httpOnly, secure, sameSite)
- [ ] JWT properly validated
- [ ] Rate limiting enabled

### Authorization
- [ ] Access control on all endpoints
- [ ] Principle of least privilege
- [ ] No sensitive data in URLs

### Secrets
- [ ] No hardcoded secrets
- [ ] .env in .gitignore
- [ ] Secrets rotated regularly

### Headers
- [ ] HTTPS enforced
- [ ] Security headers set (CSP, HSTS, etc.)
- [ ] CORS properly configured

## Commands

```bash
# Check dependencies
bunx audit

# Search for secrets
Grep: "(api[_-]?key|secret|password|token)\s*[:=]"

# Check .env exposure
Grep: "\.env" in .gitignore
```

## Common Vulnerabilities

| Issue | Fix |
|-------|-----|
| SQL injection | Use parameterized queries |
| XSS | Escape user content |
| CSRF | Use tokens |
| Open redirect | Validate redirect URLs |
| Exposed secrets | Use env variables |

## Process

1. Run automated scans
2. Review authentication/authorization
3. Check input handling
4. Verify secrets management
5. Test security headers
