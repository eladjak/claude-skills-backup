# Claude Code Skills Backup

Backup of Claude Code configuration including skills, agents, and rules.

## Contents

| Directory | Count | Description |
|-----------|-------|-------------|
| `skills/` | 170+ skills | Specialized skill definitions for Claude Code |
| `agents/` | 36 agents | Agent configurations for code review, planning, testing, etc. |
| `rules/` | 24 rules | Global rules for coding style, error handling, security, etc. |
| `CLAUDE.md` | 1 file | Main Claude Code configuration and preferences |

## Skills Categories

- **Development**: React, Next.js, Expo, TypeScript, Go, Bun
- **Backend**: Convex, Supabase, PostgreSQL, MongoDB, Redis
- **DevOps**: AWS, Cloudflare, Vercel, Railway, Docker, CI/CD
- **Testing**: TDD, E2E (Playwright), test generation
- **AI/LLM**: LangChain, fal.ai, local LLM routing
- **Security**: OWASP, auth patterns, security auditing
- **Productivity**: Git workflows, code review, project management
- **Design**: UI/UX, accessibility, motion design, Figma

## Usage

Copy directories into `~/.claude/` to restore configuration:

```bash
cp -r skills/ ~/.claude/skills/
cp -r agents/ ~/.claude/agents/
cp -r rules/ ~/.claude/rules/
cp CLAUDE.md ~/.claude/CLAUDE.md
```

## Last Backup

2026-02-13
