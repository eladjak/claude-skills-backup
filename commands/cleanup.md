---
description: Clean up and organize file system
---

Analyze a directory and suggest cleanup operations.

**Analysis includes:**
- Temporary files
- Duplicate files
- Large files
- Old files (by date)
- Cache directories
- Empty folders

**Safety first**: Always review before deletion!

## Cleanup Report

### Disk Usage
- **Total size**: [Size]
- **File count**: [Count]
- **Potential savings**: [Size]

### Findings
**Temporary Files**: [Count] files, [Size]
**Duplicates**: [Count] files, [Size]
**Large Files**: Top 10 largest files
**Old Files**: Files older than [threshold]

### Recommended Actions
1. [Safe to delete]
2. [Consider archiving]
3. [Review manually]

### Cleanup Script
```powershell
[Safe cleanup script with dry-run option]
```

**Always run with -WhatIf first!**
