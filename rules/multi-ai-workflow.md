# Multi-AI Workflow (AI Orchestra)

Don't use one AI for everything. Each AI has strengths.

## The Stack (2026)

| AI | Best For | When to Use |
|----|----------|-------------|
| **Claude Opus** | Complex code, debugging, architecture | Hard problems, 80%+ accuracy needed |
| **v0.dev** | UI/React generation | Before giving UI work to Claude |
| **Google Stitch** | UI + Figma export | When need Figma design or mobile UI |
| **Copilot Agent** | Overnight work | Issues that can wait until morning |
| **Gemini Pro** | Images, video, Google integration | Visual tasks, Drive/Calendar |
| **ChatGPT** | Brainstorming, writing, quick questions | Daily conversations |

## Key Workflows

### UI Development (Save 84% tokens)

**Option A: v0.dev (React/Tailwind)**
```
1. v0.dev → Generate UI from screenshot/description
2. Copy code to Claude
3. Claude adds: logic, backend, tests
```

**Option B: Google Stitch (Figma + Code)**
```
1. stitch.withgoogle.com → Generate UI from prompt/image
2. Export to Figma (for design iteration) OR HTML/Tailwind
3. Copy to Claude for logic/backend
```

**v0.dev vs Stitch:**
| Feature | v0.dev | Google Stitch |
|---------|--------|---------------|
| Output | React + Tailwind | HTML/Tailwind + Figma |
| Best For | Web React apps | Mobile apps, Figma workflows |
| AI Model | Custom | Gemini 2.5/3 |
| Cost | Free tier / $20/mo Pro | Free (Google Labs) |
| Prototyping | Limited | Built-in prototype linking |

**NEVER let Claude design UI from scratch - massive token waste!**

### Overnight Work
```bash
# Before sleep:
bash ~/.claude/scripts/copilot-overnight.sh

# Morning:
gh pr list --author @copilot
```

### Model Selection
```
Simple task → Cheaper model (Codex, GPT-4)
Complex task → Claude Opus
Visual task → Gemini Pro
```

## Cost Optimization

| Approach | Cost |
|----------|------|
| Claude for everything | $$$$ |
| Right tool for job | $ |

## Integration Tips

1. **v0.dev**: Free tier works, Pro ($20/mo) for heavy use
2. **Google Stitch**: Free (Google Labs), 350 gen/month standard
3. **Copilot**: $10/mo Individual plan
4. **Gemini**: Pro tier needed for quality
5. **Claude**: Use Opus for hard stuff, Sonnet for routine

## UI Tool Decision Tree

```
Need React components? → v0.dev
Need Figma export? → Stitch
Mobile app UI? → Stitch
Want to iterate in Figma? → Stitch
Want code immediately? → v0.dev
Both work? → Try both, use better result
```

## Commands

```bash
# Assign to Copilot overnight
bash ~/.claude/scripts/copilot-overnight.sh

# Check Copilot's work
gh pr list --author @copilot
```
