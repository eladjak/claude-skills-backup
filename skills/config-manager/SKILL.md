---
name: cleanup
description: Manage Claude Code configuration and settings. View, backup, and modify Claude settings. Use when managing config, checking settings, or organizing Claude setup. Triggers on config, settings, preferences, setup.
---

# Config Manager

Manage Claude Code configuration and settings.

## Commands

| Command | Description |
|---------|-------------|
| `/cleanup` | Show current config status |
| `/cleanup view <file>` | View specific config |
| `/cleanup backup` | Backup all configs |
| `/cleanup validate` | Validate configurations |

## Config Files Managed

- `settings.json` - Main settings
- `CLAUDE.md` - Global instructions
- `rules/*.md` - Rule files
- `agents/*.ps1` - Agent scripts

## Config Locations

```
~/.claude/
  settings.json    - Main settings
  CLAUDE.md        - Instructions
  rules/           - Rule files
  agents/          - Agent scripts
  skills/          - Installed skills
```
