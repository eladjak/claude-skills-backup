---
description: WebSocket and real-time patterns
---

WebSocket development helper.

## Native WebSocket (Client)

```typescript
const ws = new WebSocket('wss://api.example.com/ws')

ws.onopen = () => {
  console.log('Connected')
  ws.send(JSON.stringify({ type: 'subscribe', channel: 'updates' }))
}

ws.onmessage = (event) => {
  const data = JSON.parse(event.data)
  console.log('Received:', data)
}

ws.onclose = () => {
  console.log('Disconnected')
}

ws.onerror = (error) => {
  console.error('Error:', error)
}
```

## Socket.io

```bash
bun add socket.io socket.io-client
```

### Server
```typescript
// server.ts
import { Server } from 'socket.io'

const io = new Server(3001, {
  cors: { origin: 'http://localhost:3000' }
})

io.on('connection', (socket) => {
  console.log('Client connected:', socket.id)

  socket.on('message', (data) => {
    // Broadcast to all
    io.emit('message', data)
  })

  socket.on('join-room', (room) => {
    socket.join(room)
  })

  socket.on('disconnect', () => {
    console.log('Client disconnected')
  })
})
```

### Client
```typescript
import { io } from 'socket.io-client'

const socket = io('http://localhost:3001')

socket.on('connect', () => {
  console.log('Connected:', socket.id)
})

socket.on('message', (data) => {
  console.log('Message:', data)
})

// Send message
socket.emit('message', { text: 'Hello' })

// Join room
socket.emit('join-room', 'room-1')
```

## React Hook

```typescript
function useSocket(url: string) {
  const [socket, setSocket] = useState<Socket | null>(null)
  const [connected, setConnected] = useState(false)

  useEffect(() => {
    const s = io(url)

    s.on('connect', () => setConnected(true))
    s.on('disconnect', () => setConnected(false))

    setSocket(s)

    return () => {
      s.disconnect()
    }
  }, [url])

  return { socket, connected }
}
```

## Partykit (Serverless)

```typescript
// party/index.ts
import type { PartyKitServer } from 'partykit/server'

export default {
  onConnect(conn, room) {
    conn.send(JSON.stringify({ type: 'welcome' }))
  },

  onMessage(message, conn, room) {
    room.broadcast(message)
  }
} satisfies PartyKitServer

// Client
import PartySocket from 'partysocket'

const socket = new PartySocket({
  host: 'project.username.partykit.dev',
  room: 'my-room'
})
```

## Ably/Pusher

```typescript
import Ably from 'ably'

const ably = new Ably.Realtime(process.env.ABLY_API_KEY)
const channel = ably.channels.get('updates')

channel.subscribe('event', (message) => {
  console.log('Received:', message.data)
})

channel.publish('event', { text: 'Hello' })
```
