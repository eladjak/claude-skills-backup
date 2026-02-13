---
name: eigent-integration
description: Use when working with privacy-sensitive multi-agent workflows, local LLM deployment, or desktop automation. Triggers on local agents, privacy AI, multi-agent desktop, Eigent, CAMEL-AI.
---

# Eigent Integration

Integrate with Eigent - the open-source desktop multi-agent workforce for privacy-respecting automation.

## Overview

Eigent provides multi-agent orchestration that runs locally on your machine. All data stays local - no cloud required. Built on CAMEL-AI framework with MCP integration.

## When to Use

**Use Eigent for:**
- Privacy-sensitive client work (code stays local)
- Multi-agent workflows (parallel specialized agents)
- Desktop automation (browser, files, documents)
- Local LLM deployment (Ollama, LM Studio, vLLM)
- Enterprise environments with strict data policies

**Use cloud alternatives for:**
- Quick experiments (AutoGPT, AgentGPT faster setup)
- Non-sensitive data (simpler configuration)
- Limited hardware (Eigent needs 8GB+ RAM, GPU for local LLMs)

## Available Agents

| Agent | Purpose | MCP Tools |
|-------|---------|-----------|
| Developer Agent | Code execution, debugging | Code execution, file system |
| Browser Agent | Web search, data extraction | Browser automation |
| Document Agent | File management, processing | File read/write, PDF |
| Multi-Modal Agent | Image/audio processing | Multi-modal tools |

## Installation

### Quick Start (Cloud Backend)
```bash
git clone https://github.com/eigent-ai/eigent.git
cd eigent
npm install
npm run dev
```
Requires Node.js 18-22.

### Full Local Deployment
```bash
git clone https://github.com/eigent-ai/eigent.git
cd eigent/server
# Follow server/README_EN.md for complete setup
```

### Local LLM Setup
```bash
# Option 1: Ollama
ollama run llama3.2

# Option 2: LM Studio
# Download from lmstudio.ai, load model

# Option 3: vLLM
pip install vllm
vllm serve meta-llama/Llama-3.2-3B-Instruct
```

## Integration with Claude Code

### When to Offload to Eigent

Eigent complements Claude Code for:
1. **Parallel agent tasks** - Multiple agents work simultaneously
2. **Desktop control** - Browser, apps, file system
3. **Local LLM fallback** - When API is unavailable
4. **Sensitive operations** - Code analysis without cloud exposure

### Workflow Pattern

```
Claude Code (orchestration)
    └── Eigent (local execution)
        ├── Developer Agent → code tasks
        ├── Browser Agent → web tasks
        └── Document Agent → file tasks
```

### API Communication

Eigent exposes REST API on localhost:
```typescript
// Start task
const response = await fetch('http://localhost:8000/api/task', {
  method: 'POST',
  body: JSON.stringify({
    agents: ['developer', 'browser'],
    task: 'Research competitor pricing and summarize'
  })
});

// Check status
const status = await fetch(`http://localhost:8000/api/task/${taskId}`);
```

## MCP Integration

Eigent supports custom MCP tools:

```json
{
  "mcpServers": {
    "eigent-local": {
      "command": "node",
      "args": ["eigent/server/mcp-bridge.js"],
      "env": {
        "EIGENT_URL": "http://localhost:8000"
      }
    }
  }
}
```

## Use Cases

### Client Code Analysis (Privacy Required)
```
Task: Analyze proprietary algorithm without cloud exposure

1. Start Eigent with local LLM (Ollama)
2. Load codebase into Document Agent
3. Developer Agent analyzes patterns
4. Results stay 100% local
```

### Parallel Research
```
Task: Market research on 5 competitors

1. Start 5 Browser Agents in parallel
2. Each agent researches one competitor
3. Document Agent compiles findings
4. 5x faster than sequential
```

### Automated Workflows
```
Task: Daily report generation

1. Browser Agent fetches data
2. Developer Agent processes
3. Document Agent creates PDF
4. Human-in-the-loop for approval
```

## Hardware Requirements

| Setup | RAM | GPU | Use Case |
|-------|-----|-----|----------|
| Cloud backend | 8GB | None | API-based |
| Local small models | 16GB | Optional | 7B models |
| Local large models | 32GB+ | RTX 3080+ | 70B models |

## Common Issues

**Port conflict:**
```bash
# Check if port 8000 is in use
netstat -ano | findstr :8000
# Change port in .env
EIGENT_PORT=8001
```

**Local LLM slow:**
- Use smaller model (7B instead of 70B)
- Enable GPU acceleration
- Reduce context window

## Resources

- **GitHub**: https://github.com/eigent-ai/eigent
- **Docs**: https://www.eigent.ai/blog
- **CAMEL-AI**: https://www.camel-ai.org
- **Discord**: Community support
