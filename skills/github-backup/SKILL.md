---
name: github-backup
description: Backup Claude skills and configuration to GitHub with multi-language README generation. Use when you want to backup skills, push to GitHub, update documentation, or sync configuration. Triggers on backup skills, push to github, update readme, backup config, sync to repo.
---

# GitHub Backup & Documentation Skill

Automatically backup Claude Code skills and configuration to GitHub with comprehensive multi-language documentation.

## Commands

| Command | Description |
|---------|-------------|
| `/github-backup` | Full backup - sync skills + update READMEs |
| `/github-backup skills` | Backup only skills |
| `/github-backup docs` | Update only documentation |
| `/github-backup push` | Push changes to GitHub |

## Workflow

When this skill is invoked, perform these steps:

### Step 1: Verify GitHub Repository

Check if the target repository exists and is accessible:
```bash
gh repo view hoodini/ai-agents-skills --json name
```

### Step 2: Clone/Update Local Repository

```bash
# Clone if not exists, or pull latest
if [ -d "~/ai-agents-skills" ]; then
    cd ~/ai-agents-skills && git pull
else
    gh repo clone hoodini/ai-agents-skills ~/ai-agents-skills
fi
```

### Step 3: Sync Skills

For each skill in `~/.claude/skills/`:
1. Check if it exists in the repository
2. Compare content hashes
3. Copy new/updated skills to `~/ai-agents-skills/skills/`

**Important:** Only sync skills that have SKILL.md files (proper skill format).

### Step 4: Generate Multi-Language READMEs

Generate/update documentation in multiple languages:

**English (README.md):**
- Hero banner
- Installation instructions
- Skills table with descriptions
- Usage examples
- Contributing guide

**Hebrew (README-HE.md):**
- Same structure in Hebrew
- RTL formatting support
- Hebrew installation instructions

**Additional Languages (optional):**
- README-ES.md (Spanish)
- README-ZH.md (Chinese)
- README-JA.md (Japanese)

### Step 5: Commit and Push

```bash
cd ~/ai-agents-skills
git add .
git commit -m "chore: sync skills and update documentation

- Updated N skills
- Regenerated multi-language READMEs
- Added new skills: [list]"

git push origin main
```

### Step 6: Report Results

Display summary:
```
GitHub Backup Complete!

Skills:
  - 5 new skills added
  - 12 skills updated
  - 8 skills unchanged

Documentation:
  - README.md updated (English)
  - README-HE.md updated (Hebrew)

Repository: https://github.com/hoodini/ai-agents-skills
```

## README Template (English)

```markdown
<p align="center">
  <img src="hero-skills.jpg" alt="AI Agent Skills"/>
</p>

# AI Agent Skills Repository

A curated collection of specialized skills for AI coding agents.

## Quick Start

### Using skill-sync (Recommended)
```powershell
# Check available skills
powershell -File ~/.claude/skills/skill-sync/sync.ps1 list

# Sync all skills
powershell -File ~/.claude/skills/skill-sync/sync.ps1 sync
```

### Manual Installation
1. Clone this repository
2. Copy desired skills to `~/.claude/skills/`

## Available Skills

| Skill | Description | Triggers |
|-------|-------------|----------|
{{SKILLS_TABLE}}

## Contributing

1. Fork the repository
2. Create your skill in `skills/<skill-name>/SKILL.md`
3. Submit a pull request

## License

MIT
```

## README Template (Hebrew)

```markdown
<div dir="rtl">

<p align="center">
  <img src="hero-skills.jpg" alt="AI Agent Skills"/>
</p>

# מאגר מיומנויות לסוכני AI

אוסף מיומנויות מתמחות לסוכני קוד AI.

## התחלה מהירה

### באמצעות skill-sync (מומלץ)
```powershell
# הצגת מיומנויות זמינות
powershell -File ~/.claude/skills/skill-sync/sync.ps1 list

# סנכרון כל המיומנויות
powershell -File ~/.claude/skills/skill-sync/sync.ps1 sync
```

### התקנה ידנית
1. שכפל את המאגר
2. העתק את המיומנויות הרצויות ל-`~/.claude/skills/`

## מיומנויות זמינות

| מיומנות | תיאור | טריגרים |
|---------|-------|---------|
{{SKILLS_TABLE_HE}}

## תרומה

1. צור Fork למאגר
2. צור מיומנות ב-`skills/<skill-name>/SKILL.md`
3. שלח Pull Request

## רישיון

MIT

</div>
```

## Automation Integration

This skill can be triggered automatically via hooks:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -File ~/.claude/skills/github-backup/backup.ps1 auto"
          }
        ]
      }
    ]
  }
}
```

## Resources

- **Repository**: https://github.com/hoodini/ai-agents-skills
- **skill-sync**: Local skill synchronization
- **Claude Code Docs**: https://docs.anthropic.com/claude-code
