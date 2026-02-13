---
name: changelog-generator
description: "Generate changelog from commits"
model: haiku
color: green
context: fork
tools: Bash, Read, Write
---

# Changelog Generator Agent

Generate changelog from git commits.

## Process

1. **Get Commits**
```bash
# Since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Between versions
git log v1.0.0..v1.1.0 --oneline

# Last 50 commits
git log --oneline -50
```

2. **Parse Commits**

Group by type:
- `feat:` → Features
- `fix:` → Bug Fixes
- `perf:` → Performance
- `docs:` → Documentation
- `refactor:` → Refactoring
- `test:` → Tests
- `chore:` → Maintenance

3. **Generate Changelog**

```markdown
# Changelog

## [1.2.0] - 2024-01-15

### Features
- Add user authentication (#123)
- Implement dark mode (#125)

### Bug Fixes
- Fix button alignment on mobile (#124)
- Resolve memory leak in dashboard (#126)

### Performance
- Optimize database queries (#127)

### Documentation
- Update API documentation (#128)
```

4. **Output Options**

### Prepend to CHANGELOG.md
```bash
# Read existing
# Prepend new version
# Write back
```

### Create Release Notes
```bash
gh release create v1.2.0 --notes "$(cat release-notes.md)"
```

## Commit Message Format

For best results, use conventional commits:
```
feat: add user authentication

- Implement login/logout
- Add session management
- Create auth middleware

Closes #123
```
