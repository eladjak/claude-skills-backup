#!/usr/bin/env bash
# auto-context.sh - Auto-load project context on session start
# Runs as a SessionStart hook to provide Claude with immediate project awareness

CWD="${1:-$(pwd)}"
REGISTRY="$HOME/.claude/projects-registry.json"

# Check if this is a project directory
HAS_CLAUDE_MD=false
HAS_PROGRESS_MD=false
HAS_PACKAGE_JSON=false

[ -f "$CWD/CLAUDE.md" ] && HAS_CLAUDE_MD=true
[ -f "$CWD/PROGRESS.md" ] && HAS_PROGRESS_MD=true
[ -f "$CWD/package.json" ] && HAS_PACKAGE_JSON=true

# Exit silently if not a project directory
if [ "$HAS_CLAUDE_MD" = false ] && [ "$HAS_PROGRESS_MD" = false ] && [ "$HAS_PACKAGE_JSON" = false ]; then
  exit 0
fi

PROJECT_NAME=$(basename "$CWD")

echo "=== PROJECT CONTEXT: $PROJECT_NAME ==="
echo ""

# 1. CLAUDE.md (first 50 lines)
if [ "$HAS_CLAUDE_MD" = true ]; then
  echo "--- CLAUDE.md (first 50 lines) ---"
  head -50 "$CWD/CLAUDE.md"
  TOTAL=$(wc -l < "$CWD/CLAUDE.md" 2>/dev/null || echo "0")
  if [ "$TOTAL" -gt 50 ] 2>/dev/null; then
    echo "... ($TOTAL total lines, showing first 50)"
  fi
  echo ""
fi

# 2. PROGRESS.md (first 30 lines)
if [ "$HAS_PROGRESS_MD" = true ]; then
  echo "--- PROGRESS.md (first 30 lines) ---"
  head -30 "$CWD/PROGRESS.md"
  TOTAL=$(wc -l < "$CWD/PROGRESS.md" 2>/dev/null || echo "0")
  if [ "$TOTAL" -gt 30 ] 2>/dev/null; then
    echo "... ($TOTAL total lines, showing first 30)"
  fi
  echo ""
fi

# 3. Last 3 git commits
if [ -d "$CWD/.git" ] || git -C "$CWD" rev-parse --git-dir >/dev/null 2>&1; then
  echo "--- Last 3 Git Commits ---"
  git -C "$CWD" log --oneline -3 2>/dev/null || echo "(no commits yet)"
  echo ""
fi

# 4. Registry entry for this project
if [ -f "$REGISTRY" ]; then
  # Use node to extract the matching project entry by folder path
  CWD_FORWARD=$(echo "$CWD" | sed 's|\\|/|g')
  ENTRY=$(node -e "
    const fs = require('fs');
    try {
      const reg = JSON.parse(fs.readFileSync(process.argv[1], 'utf8'));
      const projName = process.argv[2];
      const cwdNorm = process.argv[3].replace(/\\\\/g, '/').toLowerCase();
      const match = reg.projects.find(p => {
        if (!p.folder) return false;
        const f = p.folder.replace(/\\\\/g, '/').toLowerCase();
        return f === cwdNorm || f.endsWith('/' + projName.toLowerCase());
      });
      if (match) {
        console.log('Name: ' + match.name);
        console.log('Status: ' + match.status);
        console.log('Category: ' + (match.category || 'N/A'));
        console.log('Last Session: ' + (match.lastSession || 'N/A'));
        if (match.description) console.log('Description: ' + match.description);
      } else {
        console.log('(not found in registry)');
      }
    } catch(e) { console.log('(registry read error: ' + e.message + ')'); }
  " "$REGISTRY" "$PROJECT_NAME" "$CWD_FORWARD" 2>/dev/null)
  if [ -n "$ENTRY" ]; then
    echo "--- Registry Entry ---"
    echo "$ENTRY"
    echo ""
  fi
fi

# 5. Quick project summary
echo "--- Files Present ---"
FILES=""
[ "$HAS_CLAUDE_MD" = true ] && FILES="$FILES CLAUDE.md"
[ "$HAS_PROGRESS_MD" = true ] && FILES="$FILES PROGRESS.md"
[ "$HAS_PACKAGE_JSON" = true ] && FILES="$FILES package.json"
[ -f "$CWD/.env" ] && FILES="$FILES .env"
[ -f "$CWD/tsconfig.json" ] && FILES="$FILES tsconfig.json"
[ -d "$CWD/.git" ] && FILES="$FILES .git/"
[ -d "$CWD/node_modules" ] && FILES="$FILES node_modules/"
[ -d "$CWD/src" ] && FILES="$FILES src/"
echo "$FILES"
echo ""
echo "=== END PROJECT CONTEXT ==="
echo ""
echo "[MAGIC KEYWORD: iteration-protocol]"
