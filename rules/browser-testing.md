# Browser Automation / Testing

Use `agent-browser` skill for web testing, checking UI issues, form testing, and screenshots.

## agent-browser Workflow

```bash
agent-browser open <url>           # Navigate to page
agent-browser snapshot -i          # Get interactive elements with refs (@e1, @e2)
agent-browser click @e1            # Click using ref
agent-browser fill @e2 "text"      # Fill input using ref
agent-browser screenshot page.png  # Take screenshot
agent-browser close                # Close browser
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `snapshot -i` | Get accessibility tree with refs (best for AI) |
| `click @ref` | Click element using ref from snapshot |
| `fill @ref "text"` | Fill input using ref |
| `wait --text "Welcome"` | Wait for text to appear |
| `get text @ref` | Get element text |
| `is visible @ref` | Check element visibility |
| `screenshot <filename>` | Take screenshot |

## Use Cases

- Visual verification after UI changes
- Form testing and validation
- Screenshot documentation
- Accessibility testing
- End-to-end flow testing

## Tips

- Always use `snapshot -i` to get element refs
- Use refs (@e1, @e2) instead of selectors when possible
- Take screenshots to verify visual changes
- Use `wait` commands for dynamic content
