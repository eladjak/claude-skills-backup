---
description: Create a GitHub pull request with proper summary
---

Create a well-structured GitHub PR.

## Process

1. **Analyze Changes** - Full commit history since branch diverged
2. **Check Remote** - Verify branch is pushed and up-to-date
3. **Create PR** - Use `gh pr create` with structured body

## Commands

```bash
# 1. See all changes
git log main..HEAD --oneline
git diff main...HEAD

# 2. Push if needed
git push -u origin HEAD

# 3. Create PR with HEREDOC
gh pr create --title "feat: description" --body "$(cat <<'EOF'
## Summary
- Change 1
- Change 2

## Test plan
- [ ] Test case 1
- [ ] Test case 2

🤖 Generated with Claude Code
EOF
)"
```

## PR Title Format

```
<type>: <description>
```

Types: feat, fix, refactor, docs, test, chore, perf

## Rules

- Analyze ALL commits, not just the latest
- Include test plan with checkboxes
- Return the PR URL when done
- Don't push to main/master directly
