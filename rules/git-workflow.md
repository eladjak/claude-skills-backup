# Git Workflow

## Commit Message Format

```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

Note: Attribution disabled globally via ~/.claude/settings.json.

## Pull Request Workflow

When creating PRs:
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

## Feature Implementation Workflow

1. **Branch Setup**
   - Use `using-git-worktrees` skill for isolated feature development
   - Or create feature branch: `git checkout -b feat/feature-name`

2. **Plan First**
   - Use `writing-plans` + `planning-with-files` skills
   - Use **planner** agent for complex implementation plans
   - Identify dependencies and risks
   - Break down into phases

3. **Execute Plan**
   - Use `executing-plans` skill to follow the written plan
   - Use `dispatching-parallel-agents` for independent sub-tasks
   - Use **tdd-guide** agent for TDD approach (RED → GREEN → REFACTOR)
   - Verify 80%+ coverage

4. **Code Review**
   - Use `requesting-code-review` skill + **code-reviewer** agent
   - Address CRITICAL and HIGH issues
   - Use `receiving-code-review` skill when processing feedback

5. **Finish & Merge**
   - Use `finishing-a-development-branch` skill (cleanup, squash, PR)
   - Use `verification-before-completion` skill before marking done
   - Detailed commit messages following conventional commits
