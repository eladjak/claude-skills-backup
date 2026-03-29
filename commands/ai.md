---
description: AI/LLM integration patterns
---

AI/LLM development helper.

## OpenAI

```typescript
import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
})

// Chat completion
const response = await openai.chat.completions.create({
  model: 'gpt-4-turbo',
  messages: [
    { role: 'system', content: 'You are helpful.' },
    { role: 'user', content: 'Hello!' }
  ]
})

// Streaming
const stream = await openai.chat.completions.create({
  model: 'gpt-4-turbo',
  messages: [...],
  stream: true
})

for await (const chunk of stream) {
  process.stdout.write(chunk.choices[0]?.delta?.content || '')
}
```

## Anthropic

```typescript
import Anthropic from '@anthropic-ai/sdk'

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY
})

const response = await anthropic.messages.create({
  model: 'claude-sonnet-4-20250514',
  max_tokens: 1024,
  messages: [
    { role: 'user', content: 'Hello!' }
  ]
})
```

## Vercel AI SDK

```typescript
import { generateText, streamText } from 'ai'
import { openai } from '@ai-sdk/openai'

// Generate
const { text } = await generateText({
  model: openai('gpt-4-turbo'),
  prompt: 'Write a poem'
})

// Stream (React)
const { textStream } = await streamText({
  model: openai('gpt-4-turbo'),
  prompt: 'Write a story'
})

for await (const text of textStream) {
  console.log(text)
}
```

## Best Practices

- Always use environment variables for API keys
- Implement rate limiting
- Handle errors gracefully
- Use streaming for long responses
- Cache responses when appropriate
- Log token usage for cost tracking

## Prompt Engineering

```typescript
const systemPrompt = `
You are a helpful assistant.

## Instructions
- Be concise
- Use markdown formatting
- If unsure, say so

## Context
{context}
`
```
