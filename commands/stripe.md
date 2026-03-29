---
description: Stripe payment integration patterns
---

Stripe development helper.

## Setup

```bash
bun add stripe @stripe/stripe-js
```

## Server-side

```typescript
// lib/stripe.ts
import Stripe from 'stripe'

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-04-10'
})
```

## Create Checkout Session

```typescript
// app/api/checkout/route.ts
import { stripe } from '@/lib/stripe'

export async function POST(request: Request) {
  const { priceId } = await request.json()

  const session = await stripe.checkout.sessions.create({
    mode: 'subscription', // or 'payment'
    payment_method_types: ['card'],
    line_items: [{ price: priceId, quantity: 1 }],
    success_url: `${process.env.NEXT_PUBLIC_URL}/success?session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${process.env.NEXT_PUBLIC_URL}/cancel`
  })

  return Response.json({ url: session.url })
}
```

## Webhooks

```typescript
// app/api/webhooks/stripe/route.ts
import { stripe } from '@/lib/stripe'
import { headers } from 'next/headers'

export async function POST(request: Request) {
  const body = await request.text()
  const signature = headers().get('stripe-signature')!

  const event = stripe.webhooks.constructEvent(
    body,
    signature,
    process.env.STRIPE_WEBHOOK_SECRET!
  )

  switch (event.type) {
    case 'checkout.session.completed':
      const session = event.data.object
      // Handle successful checkout
      break

    case 'customer.subscription.updated':
      // Handle subscription update
      break

    case 'customer.subscription.deleted':
      // Handle cancellation
      break
  }

  return Response.json({ received: true })
}
```

## Client-side

```tsx
import { loadStripe } from '@stripe/stripe-js'

const stripePromise = loadStripe(process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY!)

async function handleCheckout() {
  const response = await fetch('/api/checkout', {
    method: 'POST',
    body: JSON.stringify({ priceId: 'price_xxx' })
  })
  const { url } = await response.json()
  window.location.href = url
}
```

## CLI Commands

```bash
# Listen to webhooks locally
stripe listen --forward-to localhost:3000/api/webhooks/stripe

# Trigger test events
stripe trigger payment_intent.succeeded

# List products
stripe products list
```
