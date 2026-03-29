---
description: Deployment commands and workflows
---

Deployment helper.

## Vercel

```bash
# Deploy preview
bunx vercel

# Deploy production
bunx vercel --prod

# List deployments
bunx vercel ls

# View logs
bunx vercel logs <url>

# Set env var
bunx vercel env add SECRET_KEY
```

## GitHub Pages

```bash
# Using gh-pages package
bunx gh-pages -d dist

# Or using gh CLI
gh repo set-default
gh pages deploy dist
```

## Railway

```bash
# Login
railway login

# Init project
railway init

# Deploy
railway up

# View logs
railway logs
```

## Fly.io

```bash
# Login
flyctl auth login

# Create app
flyctl launch

# Deploy
flyctl deploy

# View logs
flyctl logs
```

## Pre-deploy Checklist

- [ ] All tests pass
- [ ] Build succeeds locally
- [ ] Environment variables set
- [ ] No secrets in code
- [ ] Database migrations ready
- [ ] CORS configured
- [ ] Error tracking setup

## Environment Variables

```bash
# Vercel
vercel env add DATABASE_URL

# Railway
railway variables set DATABASE_URL=xxx

# Fly.io
flyctl secrets set DATABASE_URL=xxx
```

## Rollback

```bash
# Vercel
vercel rollback

# Fly.io
flyctl releases list
flyctl deploy --image <previous-image>
```
