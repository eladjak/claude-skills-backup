---
description: Stage changes and create a well-formatted git commit
---

Create a git commit following project conventions.

## Process

1. **Check Status** - Run `git status` and `git diff` to understand changes
2. **Review History** - Check recent commit messages for style consistency
3. **Stage Files** - Add specific files (avoid `git add -A` to prevent accidental commits)
4. **Write Message** - Follow conventional commits format

## Commit Format

```
<type>: <description>

<optional body explaining why>
```

**Types:** feat, fix, refactor, docs, test, chore, perf, ci

## Rules

- **NEVER** use `--no-verify` or skip hooks
- **NEVER** amend without explicit request
- **ALWAYS** stage specific files, not all
- **ALWAYS** use HEREDOC for multi-line messages
- **DON'T** commit .env, credentials, or secrets
- **DON'T** commit if pre-commit hook fails - fix first, then NEW commit

## Example

```bash
# Stage specific files
git add src/auth/login.ts src/auth/logout.ts

# Commit with HEREDOC
git commit -m "$(cat <<'EOF'
feat: add logout functionality

Adds logout button and session cleanup logic.
EOF
)"
```

## After Commit

Run `git status` to verify success.
