---
description: Initialize a new project with best practices
---

Set up a new project with proper structure.

## TypeScript/Bun Project

```bash
# Create project
bun init

# Add common dev dependencies
bun add -d typescript @types/node ultracite

# Create structure
mkdir -p src tests docs
```

## Recommended Structure

```
project/
├── src/
│   ├── index.ts
│   ├── types/
│   └── utils/
├── tests/
├── docs/
├── package.json
├── tsconfig.json
├── .gitignore
└── README.md
```

## Essential Files

### tsconfig.json
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "noEmit": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
```

### .gitignore
```
node_modules/
dist/
.env
*.log
```

## Process

1. Ask user for project type (web, api, cli, library)
2. Create appropriate structure
3. Initialize git
4. Add essential config files
5. Install dependencies with bun
