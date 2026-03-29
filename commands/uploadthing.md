---
description: UploadThing file upload patterns
---

UploadThing file upload helper.

## Setup

```bash
bun add uploadthing @uploadthing/react
```

## Server Config

```typescript
// app/api/uploadthing/core.ts
import { createUploadthing, type FileRouter } from 'uploadthing/next'

const f = createUploadthing()

export const ourFileRouter = {
  imageUploader: f({ image: { maxFileSize: '4MB', maxFileCount: 4 } })
    .middleware(async ({ req }) => {
      const user = await getUser(req)
      if (!user) throw new Error('Unauthorized')
      return { userId: user.id }
    })
    .onUploadComplete(async ({ metadata, file }) => {
      console.log('Upload complete:', file.url)
      return { url: file.url }
    }),

  pdfUploader: f({ pdf: { maxFileSize: '16MB' } })
    .middleware(async () => ({}))
    .onUploadComplete(async ({ file }) => {
      return { url: file.url }
    })
} satisfies FileRouter

export type OurFileRouter = typeof ourFileRouter
```

## API Route

```typescript
// app/api/uploadthing/route.ts
import { createRouteHandler } from 'uploadthing/next'
import { ourFileRouter } from './core'

export const { GET, POST } = createRouteHandler({
  router: ourFileRouter
})
```

## Client Usage

```tsx
'use client'

import { UploadButton, UploadDropzone } from '@uploadthing/react'
import type { OurFileRouter } from '@/app/api/uploadthing/core'

export function ImageUpload() {
  return (
    <UploadButton<OurFileRouter>
      endpoint="imageUploader"
      onClientUploadComplete={(res) => {
        console.log('Files:', res)
      }}
      onUploadError={(error) => {
        console.error('Error:', error)
      }}
    />
  )
}

// Or dropzone
export function DropzoneUpload() {
  return (
    <UploadDropzone<OurFileRouter>
      endpoint="imageUploader"
      onClientUploadComplete={(res) => {
        console.log('Files:', res)
      }}
    />
  )
}
```

## Custom Hook

```tsx
import { useUploadThing } from '@uploadthing/react'

function MyComponent() {
  const { startUpload, isUploading } = useUploadThing('imageUploader', {
    onClientUploadComplete: (res) => {
      console.log('Uploaded:', res)
    }
  })

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || [])
    startUpload(files)
  }

  return <input type="file" onChange={handleFileChange} disabled={isUploading} />
}
```
