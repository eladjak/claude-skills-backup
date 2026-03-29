---
description: Expo and React Native commands
---

Expo/React Native development helper.

## Quick Commands

```bash
# Start dev
bunx expo start

# Run on iOS
bunx expo run:ios

# Run on Android
bunx expo run:android

# Build
bunx eas build

# Update OTA
bunx eas update
```

## Project Structure

```
app/
├── (tabs)/
│   ├── _layout.tsx
│   ├── index.tsx
│   └── settings.tsx
├── [id].tsx
├── _layout.tsx
└── +not-found.tsx
```

## Expo Router

### Basic Layout
```tsx
import { Stack } from 'expo-router'

export default function Layout() {
  return <Stack />
}
```

### Tabs
```tsx
import { Tabs } from 'expo-router'

export default function TabLayout() {
  return (
    <Tabs>
      <Tabs.Screen name="index" options={{ title: 'Home' }} />
    </Tabs>
  )
}
```

### Navigation
```tsx
import { Link, router } from 'expo-router'

// Link component
<Link href="/profile">Profile</Link>

// Programmatic
router.push('/profile')
router.replace('/home')
router.back()
```

## Common Patterns

### Safe Area
```tsx
import { SafeAreaView } from 'react-native-safe-area-context'
```

### Platform Specific
```tsx
import { Platform } from 'react-native'

const styles = {
  padding: Platform.OS === 'ios' ? 20 : 16
}
```

### Async Storage
```tsx
import AsyncStorage from '@react-native-async-storage/async-storage'

await AsyncStorage.setItem('key', 'value')
const value = await AsyncStorage.getItem('key')
```

## Performance

- Use `FlatList` for long lists
- Memoize with `React.memo`
- Use `useCallback` for handlers
- Avoid inline styles
- Use Hermes engine
