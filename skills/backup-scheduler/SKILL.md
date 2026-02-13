---
name: backup
description: Create backup strategy and scripts for projects, configurations, and skills. Use when you need to backup files, schedule backups, or restore from backup. Triggers on backup, create backup, schedule backup, restore.
---

# Backup Scheduler

Automated backup management for projects and configurations.

## Commands

| Command | Description |
|---------|-------------|
| `/backup` | Show backup status |
| `/backup create <name>` | Create named backup |
| `/backup list` | List all backups |
| `/backup restore <name>` | Restore from backup |
| `/backup clean` | Remove old backups |

## What Gets Backed Up

- Claude skills (`~/.claude/skills/`)
- Claude agents (`~/.claude/agents/`)
- Claude configuration (`~/.claude/*.md`, `~/.claude/*.json`)
- Session data (optional)

## Backup Locations

- Local: `~/.claude/backups/`
- GitHub: Via github-backup skill

## Features

- Timestamped backups
- Compression support
- Retention policy (keep last N)
- Quick restore
