# Gemini Visuals

NEVER use placeholder images. Generate real images with Gemini (FREE).

## Command
```bash
cd ~/.claude/skills/nano-banana-poster/scripts
node --loader ts-node/esm generate_poster.ts "prompt"
node --loader ts-node/esm generate_poster.ts --aspect 16:9 "prompt"  # 16:9, 9:16, 1:1, 3:2
```

## Rules
- Any UI work with visual content → generate images immediately
- Hebrew projects: add "CRITICAL: All text must be in Hebrew. Layout direction is RTL."
- Copy generated images to project's public/ or assets/ folder
- For video/advanced: use fal.ai MCP (600+ models, paid)
