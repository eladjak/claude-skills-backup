---
description: Monorepo patterns and commands
---

Monorepo development helper.

## Structure

```
monorepo/
├── apps/
│   ├── web/           # Next.js app
│   ├── mobile/        # Expo app
│   └── api/           # Backend
├── packages/
│   ├── ui/            # Shared components
│   ├── utils/         # Shared utilities
│   └── config/        # Shared configs
├── package.json
├── turbo.json
└── bun.workspace.yaml
```

## Bun Workspaces

```yaml
# bun.workspace.yaml
packages:
  - "apps/*"
  - "packages/*"
```

```json
// package.json
{
  "workspaces": ["apps/*", "packages/*"]
}
```

## Turborepo

```json
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {},
    "typecheck": {
      "dependsOn": ["^build"]
    }
  }
}
```

## Commands

```bash
# Run in all packages
bun run build

# Run in specific app
bun run --filter=web dev

# Run in all apps
bun run --filter="./apps/*" build

# Run in package and dependencies
bun run --filter=web... build
```

## Shared Package

```json
// packages/ui/package.json
{
  "name": "@repo/ui",
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts",
    "./button": "./src/button.tsx"
  }
}
```

```typescript
// apps/web/...
import { Button } from '@repo/ui'
import { formatDate } from '@repo/utils'
```

## TypeScript Config

```json
// packages/config/tsconfig.base.json
{
  "compilerOptions": {
    "strict": true,
    "moduleResolution": "bundler",
    "module": "ESNext",
    "target": "ES2022"
  }
}

// apps/web/tsconfig.json
{
  "extends": "@repo/config/tsconfig.base.json",
  "include": ["src/**/*"]
}
```

## Tips

- Keep packages small and focused
- Use internal packages for shared code
- Run tasks in parallel with Turbo
- Cache aggressively
- Use consistent versioning
