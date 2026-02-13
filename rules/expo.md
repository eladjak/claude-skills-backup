---
paths:
  - "app/**"
  - "**/app/**"
  - "**/*.native.tsx"
  - "**/expo-*/**"
  - "app.json"
  - "app.config.ts"
  - "eas.json"
---

# Expo / React Native

## Skills

| Skill | When to Use |
|-------|-------------|
| `react-native-best-practices` | RN performance: FPS, TTI, bundle size, memory, re-renders, animations |
| `expo-app-design:building-ui` | Building apps with Expo Router, styling, components, navigation |
| `expo-app-design:data-fetching` | Network requests, API calls, React Query, SWR, caching |
| `expo-app-design:tailwind-setup` | Tailwind CSS v4 + NativeWind v5 setup |
| `expo-app-design:dev-client` | Build/distribute dev clients, TestFlight |
| `expo-app-design:api-routes` | API routes in Expo Router with EAS Hosting |
| `expo-app-design:use-dom` | DOM components, web code in native webview |
| `expo-deployment:deployment` | Deploy to App Store, Play Store, web |
| `expo-deployment:cicd-workflows` | EAS workflow YAML, CI/CD pipelines |
| `upgrading-expo:upgrading-expo` | Upgrade Expo SDK, fix dependency issues |

## Key Performance Guidelines

- Avoid JS thread blocking
- Use `FlashList` instead of `FlatList` for long lists
- Optimize animations with native driver
- Watch for memory leaks
- Minimize re-renders
- Use Hermes engine optimizations

## Dev Commands

```bash
bunx expo start           # Start dev server
bunx expo start --clear   # Clear cache and start
bunx eas build            # Build with EAS
bunx eas submit           # Submit to stores
bunx expo install         # Install compatible packages
```
