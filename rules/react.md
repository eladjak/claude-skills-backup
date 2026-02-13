---
paths:
  - "**/*.tsx"
  - "**/*.jsx"
  - "**/pages/**"
  - "**/app/**"
  - "next.config.*"
---

# React / Next.js

## Skills

| Skill | When to Use |
|-------|-------------|
| `vercel-react-best-practices` | Components, pages, data fetching, performance, bundle optimization |

## Key Guidelines

### Performance
- Use React Server Components where possible
- Minimize client-side JavaScript
- Optimize images with `next/image`
- Use dynamic imports for code splitting
- Implement proper caching strategies

### Data Fetching
- Prefer server-side data fetching
- Use proper revalidation strategies
- Handle loading and error states

### Rendering
- Choose correct rendering strategy (SSR, SSG, ISR)
- Use Suspense boundaries appropriately
- Avoid unnecessary re-renders

## Dev Commands

```bash
bun run dev        # Start dev server
bun run build      # Production build
bun run start      # Start production server
bunx tsc --noEmit && bunx ultracite check  # Types + linting
```
