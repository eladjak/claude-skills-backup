---
description: CI/CD configuration and workflows
---

CI/CD helper.

## GitHub Actions

### Basic CI
```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: oven-sh/setup-bun@v1
        with:
          bun-version: latest

      - run: bun install
      - run: bun run lint
      - run: bun run typecheck
      - run: bun run test
      - run: bun run build
```

### With Cache
```yaml
- uses: actions/cache@v4
  with:
    path: ~/.bun/install/cache
    key: ${{ runner.os }}-bun-${{ hashFiles('**/bun.lockb') }}
    restore-keys: |
      ${{ runner.os }}-bun-
```

### Deploy to Vercel
```yaml
deploy:
  needs: build
  runs-on: ubuntu-latest
  if: github.ref == 'refs/heads/main'

  steps:
    - uses: actions/checkout@v4
    - uses: amondnet/vercel-action@v25
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.ORG_ID }}
        vercel-project-id: ${{ secrets.PROJECT_ID }}
        vercel-args: '--prod'
```

### Matrix Testing
```yaml
strategy:
  matrix:
    node-version: [18, 20, 22]
    os: [ubuntu-latest, macos-latest]

steps:
  - uses: actions/setup-node@v4
    with:
      node-version: ${{ matrix.node-version }}
```

## Common Scripts (package.json)

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "bunx ultracite check",
    "lint:fix": "bunx ultracite fix",
    "typecheck": "tsc --noEmit",
    "test": "bun test",
    "test:watch": "bun test --watch",
    "test:coverage": "bun test --coverage"
  }
}
```

## Pre-commit Hook (package.json)

```json
{
  "simple-git-hooks": {
    "pre-commit": "bun run lint && bun run typecheck"
  }
}
```

## Branch Protection

Recommended settings:
- Require PR reviews
- Require status checks (CI must pass)
- Require up-to-date branches
- No force push to main
