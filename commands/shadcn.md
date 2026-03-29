---
description: shadcn/ui component library
---

shadcn/ui helper.

## Setup

```bash
bunx shadcn@latest init
```

## Add Components

```bash
# Single component
bunx shadcn@latest add button

# Multiple components
bunx shadcn@latest add button card input

# All components
bunx shadcn@latest add --all
```

## Common Components

```bash
# Form essentials
bunx shadcn@latest add button input label form

# Layout
bunx shadcn@latest add card dialog sheet

# Data display
bunx shadcn@latest add table badge avatar

# Navigation
bunx shadcn@latest add tabs navigation-menu dropdown-menu

# Feedback
bunx shadcn@latest add toast alert sonner
```

## Usage Examples

### Button
```tsx
import { Button } from '@/components/ui/button'

<Button variant="default">Default</Button>
<Button variant="destructive">Delete</Button>
<Button variant="outline">Outline</Button>
<Button variant="ghost">Ghost</Button>
<Button size="sm">Small</Button>
<Button disabled>Disabled</Button>
```

### Form with React Hook Form
```tsx
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { Form, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'

const form = useForm<FormData>({
  resolver: zodResolver(schema)
})

<Form {...form}>
  <form onSubmit={form.handleSubmit(onSubmit)}>
    <FormField
      control={form.control}
      name="email"
      render={({ field }) => (
        <FormItem>
          <FormLabel>Email</FormLabel>
          <Input {...field} />
          <FormMessage />
        </FormItem>
      )}
    />
    <Button type="submit">Submit</Button>
  </form>
</Form>
```

### Dialog
```tsx
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'

<Dialog>
  <DialogTrigger asChild>
    <Button>Open</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Title</DialogTitle>
    </DialogHeader>
    Content here
  </DialogContent>
</Dialog>
```

### Toast
```tsx
import { toast } from 'sonner'

toast.success('Saved!')
toast.error('Failed')
toast.loading('Saving...')
```
