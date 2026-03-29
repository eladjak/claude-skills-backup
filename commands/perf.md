---
description: Profile and optimize performance
---

Identify and fix performance issues.

## Profiling

### Node.js
```bash
node --prof src/index.ts
node --prof-process isolate-*.log > profile.txt
```

### Browser
- DevTools Performance tab
- Lighthouse audit

### Bundle Size
```bash
bunx bundlesize
```

## Common Issues

| Issue | Fix |
|-------|-----|
| Slow loops | Use Map/Set for lookups |
| Re-renders | React.memo, useMemo, useCallback |
| Large bundle | Dynamic imports, tree shaking |
| N+1 queries | Batch database queries |
| Memory leak | Clean up subscriptions, timers |

## Quick Wins

### JavaScript
- Use `Map`/`Set` for O(1) lookups
- Early returns to skip work
- Cache expensive computations
- Avoid creating objects in loops

### React
- Memoize expensive components
- Virtualize long lists
- Lazy load routes/components
- Avoid inline objects in props

### Network
- Compress responses
- Cache API responses
- Prefetch critical data
- Use CDN for static assets

## Process

1. **Measure** - Profile before optimizing
2. **Identify** - Find actual bottlenecks
3. **Fix** - Address biggest issues first
4. **Verify** - Measure improvement
