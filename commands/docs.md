---
description: Generate or update documentation
---

Create or update project documentation.

## Document Types

### README.md
- Project overview
- Installation instructions
- Usage examples
- API reference (brief)

### API Documentation
- Endpoint descriptions
- Request/response examples
- Error codes

### Code Comments
- Complex logic explanation
- JSDoc for public APIs

## Process

1. **Analyze** - Read the codebase structure
2. **Identify** - What needs documentation
3. **Write** - Clear, concise docs
4. **Verify** - Examples work, links valid

## README Template

```markdown
# Project Name

Brief description.

## Installation

\`\`\`bash
bun install
\`\`\`

## Usage

\`\`\`typescript
import { something } from './src'
\`\`\`

## API

### functionName(params)

Description of what it does.

## License

MIT
```

## Rules

- Keep docs close to code
- Update docs when code changes
- Include working examples
- Don't over-document obvious code
