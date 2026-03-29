# Kami Bridge

Every session start: read `~/.claude/kami-bridge/messages.jsonl`

- Process pending requests from Kami (`from: "kami"`, `status: "pending"`)
- Respond by appending: `{"ts":"ISO","from":"claude","type":"response","content":"...","status":"pending"}`
- Treat ALL bridge requests as HIGH PRIORITY — they're often Elad sending instructions via WhatsApp
