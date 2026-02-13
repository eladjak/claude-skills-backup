---
name: alert-system
description: Alert and notification logging system. Use when you need to set reminders, log alerts, or review pending notifications. Triggers on alert, notify, reminder, pending.
---

# Alert System

Log and manage alerts and notifications.

## Commands

| Command | Description |
|---------|-------------|
| `/alert-system add <msg>` | Add new alert |
| `/alert-system list` | Show pending alerts |
| `/alert-system done <id>` | Mark alert as done |
| `/alert-system clear` | Clear all alerts |

## Priority Levels

Add priority prefix to messages:
- `!` - High priority
- `!!` - Critical
- No prefix - Normal

## Example

```
/alert-system add "!! Review security changes before push"
/alert-system add "! Update documentation"
/alert-system add "Clean up temp files"
```
