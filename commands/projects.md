# Projects Dashboard Command

Show and manage all your projects from one place.

## Usage
When user types `/projects`, display the project dashboard.

## Workflow

1. Read the project registry from `~/.claude/projects-registry.json`
2. Display projects in a clean kanban-style board
3. Allow navigation to specific projects

## Display Format

```
╔══════════════════════════════════════════════════════════════════╗
║               📋 CLAUDE PROJECT DASHBOARD                        ║
╠══════════════════════════════════════════════════════════════════╣

┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   📥 PENDING    │  │   🔄 ACTIVE     │  │   ✅ DONE       │
├─────────────────┤  ├─────────────────┤  ├─────────────────┤
│ 📖 ספר רב מכר   │  │ 🏢 עסק ללא     │  │                 │
│    מהקורסים     │  │    מתחרים      │  │                 │
│                 │  │ 💰 פיננסים      │  │                 │
│                 │  │ 🎬 תסריטים     │  │                 │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

## Commands
- `/projects` - Show dashboard
- `/projects 1` - Open project #1
- `/projects status` - Show status summary
- `/projects add <name>` - Add new project

## Project Quick Actions
For each project, offer:
1. Open in new terminal with context
2. View last session summary
3. Update status
4. Edit project details
