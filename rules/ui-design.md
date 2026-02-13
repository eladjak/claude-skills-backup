---
paths:
  - "**/*.tsx"
  - "**/*.jsx"
  - "**/components/**"
  - "**/ui/**"
---

# UI / Design Rules

## Skills

| Skill | When to Use |
|-------|-------------|
| `ui-skills` | **Building UI** - Tailwind, motion/react, accessible primitives |
| `ui-ux-pro-max` | **Design database** - 50+ styles, 97 palettes, 57 font pairings |
| `design-motion-principles` | **Motion audit** - Emil Kowalski, Jakub Krehel techniques |
| `web-design-guidelines` | Web Interface Guidelines compliance review |

## Commands

| Command | When to Use |
|---------|-------------|
| `/rams` | **Review UI** - WCAG 2.1 accessibility audit + visual design review |

## ui-skills Constraints (ALWAYS Follow)

### Stack
- Use Tailwind CSS defaults, `cn` utility (clsx + tailwind-merge)
- Use `motion/react` for JS animations
- Use `tw-animate-css` for micro-animations

### Components
- Use accessible primitives (Base UI, React Aria, Radix)
- NEVER rebuild keyboard/focus behavior manually
- Add `aria-label` to icon-only buttons

### Layout
- Use `h-dvh` not `h-screen`
- Respect `safe-area-inset` for fixed elements
- Use fixed `z-index` scale (no arbitrary `z-*`)
- Use `size-*` for square elements

### Animation
- Animate ONLY `transform`, `opacity`
- NEVER animate `width`, `height`, `top`, `left`, `margin`, `padding`
- Max `200ms` for interaction feedback
- Respect `prefers-reduced-motion`
- Use `ease-out` on entrance

### Typography
- Use `text-balance` for headings
- Use `text-pretty` for body/paragraphs
- Use `tabular-nums` for data
- NEVER modify `letter-spacing` unless requested

### Design
- NEVER gradients/glow unless explicitly requested
- Use Tailwind CSS default shadow scale
- Limit accent color to one per view
- Give empty states one clear next action

## rams Review Categories

### Critical (Must Fix)
- Images without `alt`
- Icon-only buttons without `aria-label`
- Form inputs without labels
- Non-semantic click handlers (`<div onClick>`)

### Serious (Should Fix)
- Focus outline removed without replacement
- Missing keyboard handlers
- Color-only information
- Touch target < 44x44px

### Visual
- Layout, typography, color contrast
- Component states (hover, focus, disabled, loading)

## MCPs

### Icons (Hugeicons)
| Tool | Purpose |
|------|---------|
| `mcp__hugeicons__search_icons` | Find icons by name/keyword |
| `mcp__hugeicons__list_icons` | List available icons |
| `mcp__hugeicons__get_icon_glyphs` | Get icon SVG/glyphs |
| `mcp__hugeicons__get_icon_glyph_by_style` | Get icon in specific style |
| `mcp__hugeicons__get_platform_usage` | Icon usage for React/Vue/etc |

### Animation (Motion)
| Tool | Purpose |
|------|---------|
| `mcp__motion__generate-css-spring` | Generate spring animations |
| `mcp__motion__generate-css-bounce-easing` | Generate bounce easing curves |
