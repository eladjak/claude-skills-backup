---
name: zoom-ai-participant
description: "Work on Zoom AI Participant project - Claude as meeting participant via audio"
model: inherit
color: purple
context: fork
tools: Read, Edit, Write, Bash, Grep, Glob, LSP
skills: zoom-ai-participant
---

# Zoom AI Participant Agent

Specialized agent for developing the zoom-ai-participant project.

## Context Loading

```
Read(file_path="~/zoom-ai-participant/CLAUDE.md")
Read(file_path="~/zoom-ai-participant/.claude/PROGRESS.md")
```

## Project Commands

| Command | Purpose |
|---------|---------|
| `bun run start` | Start AI participant |
| `bun run start --devices` | List audio devices |
| `bun run start --test-audio` | Test full pipeline |
| `bun run start --test-capture` | Test capture only |
| `bun run start --test-output` | Test output only |

## Service Architecture

| Service | File | Purpose |
|---------|------|---------|
| AudioCaptureService | `audio-capture.ts` | FFmpeg dshow |
| AudioOutputService | `audio-output.ts` | ffplay + WAV |
| TranscriptionService | `transcription.ts` | Deepgram WS |
| BrainService | `brain.ts` | Claude API |
| SpeechService | `speech.ts` | ElevenLabs TTS |
| Orchestrator | `orchestrator.ts` | Coordination |

## Key Development Tasks

### Audio Capture Issues
1. Check FFmpeg availability
2. Verify device name parsing
3. Test dshow capture
4. Check VoiceMeeter routing

### Audio Output Issues
1. Verify VB-Cable installation
2. Check ffplay availability
3. Test temp WAV file creation
4. Verify cleanup after playback

### Transcription Issues
1. Check Deepgram API key
2. Verify WebSocket connection
3. Test audio format compatibility
4. Check diarization settings

### Response Logic Issues
1. Review trigger patterns in brain.ts
2. Check Claude API key
3. Verify response decision logic
4. Test Hebrew pattern matching

### TTS Issues
1. Check ElevenLabs API key
2. Verify voice ID
3. Test WebSocket streaming
4. Check audio format conversion

## Testing Workflow

```bash
# 1. Test devices
bun run start --devices

# 2. Test audio output (VB-Cable)
bun run start --test-output

# 3. Test audio capture
bun run start --test-capture

# 4. Full integration
bun run start
```

## Update Progress

After completing work, update:
```
Edit(file_path="~/zoom-ai-participant/.claude/PROGRESS.md")
```
