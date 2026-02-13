---
name: eitan-quote-generator
description: Generate event quotes for Eitan Events using pre-built templates
trigger: When user asks to generate a quote, proposal, or event pricing for Eitan Events
---

# Eitan Events - Quote Generator

## Available Templates

| Template ID | Name | Format |
|-------------|------|--------|
| `gibush_2day` | גיבוש דו-יומי | Program (multi-day itinerary) |
| `dining_evening` | ערב סועדים ונהנים | Per-person pricing |
| `interactive_exhibition` | תערוכה אינטראקטיבית | Total price (10 stations) |

## Workflow

1. **Select template**: Read `src/templates/event-templates.ts` and pick the right one
2. **Customize**: Apply client overrides (participants, date, location, budget)
3. **Fill HTML**: Read `src/templates/quote-template.html` and fill placeholders
4. **Generate PDF**: Use html-to-pdf skill with `--rtl --margin=0 --wait=2000`

## Template Customization

```typescript
import { getEventTemplate } from "../src/templates/event-templates"
import { renderQuote } from "../src/quote-builder/render-quote"

const template = getEventTemplate("gibush_2day")
const quote = {
  ...template,
  clientName: "שם הלקוח",
  eventDate: "2026-03-15",
  participants: 300,
  location: "צפון",
  // Override pricing, items, etc.
}
```

## Quote HTML Placeholders

| Placeholder | Value |
|-------------|-------|
| `{{COMPANY_NAME}}` | שם לקוח |
| `{{EVENT_TYPE}}` | סוג האירוע |
| `{{DATE}}` | תאריך |
| `{{PARTICIPANTS}}` | מספר משתתפים |
| `{{TOTAL_PRICE}}` | מחיר כולל |
| `{{PROGRAM_SECTION}}` | תוכנית (מתבנית) |
| `{{MENU_SECTION}}` | תפריט (מתבנית) |
| `{{INCLUDES_LIST}}` | כלול במחיר |
| `{{EXCLUDES_LIST}}` | לא כלול |

## Pricing Rules

- Default profit margin: 15%
- Supplier scoring: reliability 35%, price 25%, approval 20%, region 20%
- Auto-send when AI confidence >= 70%
- VAT included in all prices

## Project Path

`C:\Users\eladj\eitan-events-project\`
