---
description: State management patterns
---

State management helper.

## Zustand (Recommended)

### Setup
```bash
bun add zustand
```

### Store
```typescript
import { create } from 'zustand'

interface UserStore {
  user: User | null
  setUser: (user: User) => void
  logout: () => void
}

export const useUserStore = create<UserStore>((set) => ({
  user: null,
  setUser: (user) => set({ user }),
  logout: () => set({ user: null })
}))
```

### Usage
```tsx
function Profile() {
  const user = useUserStore((state) => state.user)
  const logout = useUserStore((state) => state.logout)

  return (
    <div>
      <p>{user?.name}</p>
      <button onClick={logout}>Logout</button>
    </div>
  )
}
```

### Persist
```typescript
import { persist } from 'zustand/middleware'

const useStore = create(
  persist<State>(
    (set) => ({ ... }),
    { name: 'store-key' }
  )
)
```

## React Query / TanStack Query

### Setup
```bash
bun add @tanstack/react-query
```

### Provider
```tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'

const queryClient = new QueryClient()

<QueryClientProvider client={queryClient}>
  <App />
</QueryClientProvider>
```

### Query
```tsx
function Users() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['users'],
    queryFn: () => fetch('/api/users').then(r => r.json())
  })

  if (isLoading) return <Loading />
  if (error) return <Error />
  return <UserList users={data} />
}
```

### Mutation
```tsx
const mutation = useMutation({
  mutationFn: (newUser) => createUser(newUser),
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: ['users'] })
  }
})

mutation.mutate({ name: 'John' })
```

## Context (Simple Cases)

```tsx
const ThemeContext = createContext<'light' | 'dark'>('light')

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState<'light' | 'dark'>('light')

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

// Usage
const { theme } = useContext(ThemeContext)
```
