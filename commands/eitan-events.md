---
description: "Eitan Events project status and quick actions"
---

Show Eitan Events project status and available actions.

## Project Directory

`C:\Users\eladj\eitan-events-project`

## Current Status

**Phase:** Proposal Complete - Waiting to Send
**Blocked by:** Sending proposal to Alon
**All proposal documents are ready.** Three versions (styled, visual, formal) generated as HTML and PDF.

## Always Read First

1. `C:\Users\eladj\eitan-events-project\PROGRESS.md` - Full project history
2. `C:\Users\eladj\eitan-events-project\CLAUDE.md` - Project instructions (if exists)

## Key Files

| File | Description |
|------|-------------|
| `05-PROPOSAL-FOR-ALON-v5.md` | Source proposal markdown |
| `proposal-eitan-events-v5.html` | Original styled proposal (HTML) |
| `proposal-eitan-events-v5.pdf` | Original styled proposal (PDF) |
| `proposal-eitan-events-v5-visual.html` | Visual proposal with event imagery (HTML) |
| `proposal-eitan-events-v5-visual.pdf` | Visual proposal with event imagery (PDF) |
| `proposal-formal-v5.html` | Formal 14-page business document (HTML) |
| `proposal-formal-v5.pdf` | Formal 14-page business document (PDF) |
| `whatsapp-message-for-alon.md` | WhatsApp messages ready to send to Alon |
| `scripts/generate-proposal-images.js` | fal-ai image generator (needs balance top-up) |
| `PROGRESS.md` | Full project history and progress log |

## Quick Actions

| Action | Command |
|--------|---------|
| Generate AI images | `cd C:/Users/eladj/eitan-events-project && FAL_KEY=$(cat ~/.claude/.env \| grep FAL_KEY \| cut -d= -f2) node scripts/generate-proposal-images.js` |
| Generate PDF from HTML | `node ~/.claude/skills/html-to-pdf/scripts/html-to-pdf.js <input.html> <output.pdf> --rtl --margin=0 --wait=3000` |
| Preview with Playwright | Start `http-server` in project dir, then navigate to `localhost:8765` |

## Key Info

- **Client**: Alon (eitan-events.com)
- **170 suppliers**, 70 concurrent quotes in season
- **Pricing**: MVP 8K-12K NIS / Full 26K-38K NIS / Creative +5K-8K NIS

## Next Steps

1. **Send proposal to Alon** - Use WhatsApp messages from `whatsapp-message-for-alon.md`
2. **Get approval** - Alon reviews and picks a package
3. **Start MVP development** - Begin implementation based on chosen package

## Known Issues

- **fal.ai balance exhausted** - Image generation script needs balance top-up before running
- **http-server for Playwright** - May need restart; run `npx http-server -p 8765` in project dir before preview
