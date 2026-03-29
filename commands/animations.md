---
description: Animation patterns with Framer Motion
---

Animation helper.

## Framer Motion Basics

### Setup
```bash
bun add framer-motion
```

### Basic Animation
```tsx
import { motion } from 'framer-motion'

<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  exit={{ opacity: 0, y: -20 }}
  transition={{ duration: 0.2 }}
>
  Content
</motion.div>
```

### Variants
```tsx
const variants = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0 },
  exit: { opacity: 0, y: -20 }
}

<motion.div
  variants={variants}
  initial="hidden"
  animate="visible"
  exit="exit"
/>
```

### AnimatePresence
```tsx
import { AnimatePresence } from 'framer-motion'

<AnimatePresence mode="wait">
  {isVisible && (
    <motion.div
      key="modal"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      Modal content
    </motion.div>
  )}
</AnimatePresence>
```

### Gestures
```tsx
<motion.button
  whileHover={{ scale: 1.05 }}
  whileTap={{ scale: 0.95 }}
>
  Click me
</motion.button>
```

### Layout Animations
```tsx
<motion.div layout>
  {items.map(item => (
    <motion.div key={item.id} layout>
      {item.content}
    </motion.div>
  ))}
</motion.div>
```

## Performance Rules

| ✓ Do | ✗ Don't |
|------|---------|
| Animate `transform` | Animate `width/height` |
| Animate `opacity` | Animate `top/left` |
| Use `will-change` sparingly | Animate `margin/padding` |
| Keep duration ≤ 200ms for feedback | Long animations for UI feedback |

## CSS Transitions (Simple)

```css
.button {
  transition: transform 0.15s ease, opacity 0.15s ease;
}

.button:hover {
  transform: scale(1.02);
}

.button:active {
  transform: scale(0.98);
}
```

## Tailwind Animations

```tsx
// Built-in
<div className="animate-spin" />
<div className="animate-pulse" />
<div className="animate-bounce" />

// Transitions
<button className="transition-transform hover:scale-105 active:scale-95">
  Click
</button>
```
