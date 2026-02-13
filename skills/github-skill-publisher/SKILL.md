---
name: github-skill-publisher
description: Use when publishing new skills to GitHub, syncing local skills to remote repository, or contributing skills to shared collections. Activate for skill backup, sharing, or version control of Claude skills.
---

# GitHub Skill Publisher

Publish and sync Claude skills to GitHub repositories for backup, sharing, and version control.

## Quick Reference

| Action | Command |
|--------|---------|
| Publish skill | Copy to repo, commit, push |
| Sync all | Copy all skills, commit, push |
| Pull updates | Git pull in skills repo |

## Prerequisites

- GitHub CLI (`gh`) authenticated
- Local clone of skills repository
- Write access to the repo

## Repository Setup

### Fork or Create Skills Repo

```bash
# Fork existing collection
gh repo fork hoodini/ai-agents-skills --clone

# Or create new repo
gh repo create my-claude-skills --public --clone
```

### Configure Local Path

Add to `~/.claude/CLAUDE.md` or environment:
```
SKILLS_REPO="$HOME/ai-agents-skills"
```

## Publishing Workflow

### 1. Copy Skill to Repo

```bash
SKILL_NAME="my-new-skill"
SKILLS_REPO="$HOME/ai-agents-skills"

cp -r "$HOME/.claude/skills/$SKILL_NAME" "$SKILLS_REPO/"
```

### 2. Commit with Good Message

```bash
cd "$SKILLS_REPO"

git add "$SKILL_NAME/"
git commit -m "$(cat <<'EOF'
feat: Add [skill-name] skill for [purpose]

[Brief description of what the skill does]

Key features:
- Feature 1
- Feature 2
EOF
)"
```

### 3. Push to GitHub

```bash
git push origin master
```

## Commit Message Format

Follow conventional commits:

| Type | When to Use |
|------|-------------|
| `feat:` | New skill |
| `fix:` | Bug fix in skill |
| `docs:` | Documentation update |
| `refactor:` | Restructure without changing behavior |
| `chore:` | Maintenance tasks |

### Good Examples

```
feat: Add project-launcher skill for kanban management

New skill that provides:
- Project kanban board management
- Status tracking
- Auto-launch with prompts
```

```
fix: Correct Hebrew RTL handling in project-launcher

- Fix prompt escaping for Hebrew text
- Add proper encoding for special chars
```

## Batch Publishing

### Publish All New/Modified Skills

```bash
#!/bin/bash
SKILLS_REPO="$HOME/ai-agents-skills"
LOCAL_SKILLS="$HOME/.claude/skills"

cd "$SKILLS_REPO"

# Copy all skills
for skill in "$LOCAL_SKILLS"/*/; do
    skill_name=$(basename "$skill")
    # Skip if already exists and unchanged
    if [ ! -d "$skill_name" ] || ! diff -rq "$skill" "$skill_name" > /dev/null 2>&1; then
        cp -r "$skill" .
        echo "Updated: $skill_name"
    fi
done

# Commit all changes
git add .
git commit -m "chore: Sync skills from local machine"
git push
```

## Pull Updates from Remote

```bash
cd "$SKILLS_REPO"
git pull origin master

# Optionally copy back to local
cp -r skills-folder/* "$HOME/.claude/skills/"
```

## Contributing to Shared Collections

### 1. Fork the Original Repo

```bash
gh repo fork hoodini/ai-agents-skills
```

### 2. Add Your Skill

```bash
cd ai-agents-skills
cp -r "$HOME/.claude/skills/my-skill" .
git add my-skill/
git commit -m "feat: Add my-skill for [purpose]"
git push origin master
```

### 3. Create Pull Request

```bash
gh pr create --title "Add my-skill" --body "$(cat <<'EOF'
## New Skill: my-skill

**Purpose:** Brief description

**Features:**
- Feature 1
- Feature 2

**Usage:**
```
/my-skill
```
EOF
)"
```

## Skill Quality Checklist

Before publishing, verify:

- [ ] SKILL.md has proper frontmatter (name, description)
- [ ] Description starts with "Use when..."
- [ ] Clear Quick Reference section
- [ ] Working examples/scripts tested
- [ ] No hardcoded paths (use $HOME)
- [ ] Hebrew content properly encoded (UTF-8)

## Directory Structure in Repo

```
ai-agents-skills/
├── project-launcher/
│   ├── SKILL.md
│   └── projects-cli.sh
├── html-to-pdf/
│   ├── SKILL.md
│   └── scripts/
├── another-skill/
│   └── SKILL.md
└── README.md
```

## Automation Script

Save as `~/.claude/scripts/publish-skill.sh`:

```bash
#!/bin/bash
# Publish a skill to GitHub
# Usage: publish-skill.sh <skill-name>

SKILL_NAME="$1"
SKILLS_REPO="$HOME/ai-agents-skills"
LOCAL_SKILL="$HOME/.claude/skills/$SKILL_NAME"

if [ -z "$SKILL_NAME" ]; then
    echo "Usage: publish-skill.sh <skill-name>"
    exit 1
fi

if [ ! -d "$LOCAL_SKILL" ]; then
    echo "Skill not found: $LOCAL_SKILL"
    exit 1
fi

# Copy skill
cp -r "$LOCAL_SKILL" "$SKILLS_REPO/"

# Commit and push
cd "$SKILLS_REPO"
git add "$SKILL_NAME/"
git commit -m "feat: Update $SKILL_NAME skill"
git push origin master

echo "Published: $SKILL_NAME"
echo "URL: https://github.com/$(gh api user --jq .login)/ai-agents-skills/tree/master/$SKILL_NAME"
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Push rejected | Pull first: `git pull --rebase` |
| Auth failed | Re-auth: `gh auth login` |
| Fork outdated | Sync fork: `gh repo sync` |
| Hebrew garbled | Ensure UTF-8 in all files |
