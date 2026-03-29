---
description: Show project directory structure
---

Display project structure as a tree.

## Commands

### Basic Tree
```bash
tree -I 'node_modules|.git|dist|build' .
```

### With Depth Limit
```bash
tree -I 'node_modules|.git|dist' -L 3 .
```

### Only Directories
```bash
tree -I 'node_modules|.git' -d .
```

### Specific Directory
```bash
tree -I 'node_modules' src/
```

## Common Ignore Patterns

| Project Type | Ignore Pattern |
|--------------|----------------|
| Node/JS | `node_modules\|dist\|build\|.next\|coverage` |
| React Native | `node_modules\|.expo\|android\|ios\|build` |
| Python | `__pycache__\|.venv\|venv\|dist` |
| Go | `vendor\|bin` |

## Useful Flags

| Flag | Purpose |
|------|---------|
| `-L N` | Limit depth to N levels |
| `-d` | Directories only |
| `-I 'pattern'` | Ignore pattern |
| `-a` | Show hidden files |
| `--dirsfirst` | List directories before files |

## Example Output

```
project/
├── src/
│   ├── components/
│   ├── hooks/
│   ├── utils/
│   └── index.ts
├── tests/
├── package.json
└── tsconfig.json
```
