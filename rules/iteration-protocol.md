# Iteration Protocol - MANDATORY for Every Project Session

## CRITICAL: This runs AUTOMATICALLY at the start and end of every project iteration

## How to Activate (3 layers, any one works)

### Layer 1: Automatic (SessionStart hook)
The `auto-context.sh` hook outputs `[MAGIC KEYWORD: iteration-protocol]` which triggers this protocol.
This runs EVERY session. If Claude sees this keyword → follow the full protocol below.

### Layer 2: Manual Command
Elad can type `/go` to explicitly activate the full protocol. This runs the `go.md` command.

### Layer 3: Natural Language Triggers
Any of these phrases should activate the full protocol:
- "יאללה" / "קדימה" / "בוא נתחיל" / "let's go"
- "פרוטוקול" / "protocol" / "iteration"
- "מה המצב?" / "status" / "where were we?"
- "תעבוד על [project]" / "work on [project]"
- Or simply opening Claude in a project directory (auto-context handles this)

### Layer 4: Always-On (The Real Goal)
Even WITHOUT explicit activation, Claude should ALWAYS:
1. Read PROGRESS.md if it exists
2. Scan for relevant capabilities
3. Apply the growth directive
4. End with an iteration review

This is not optional. It's how we work.

## Phase 1: Session Start (BEFORE any work)

### 1.1 Read Context
```
1. Read CLAUDE.md + PROGRESS.md
2. Read ~/.claude/projects-registry.json (check project status)
3. Read Kami bridge messages (~/.claude/kami-bridge/messages.jsonl)
4. Read MEMORY.md for relevant context
5. Check Scheduled Tasks status (CronList)
6. Read project-specific briefs in docs/ folder
7. Check AgenTopology config (.at) for agent network status
```

### 1.2 Scan Available Capabilities
AUTOMATICALLY scan and load relevant tools for THIS project:
- **Skills**: Check `~/.claude/skills/` + installed skills list for project-relevant skills (352+)
- **MCPs**: Check `~/.claude/.mcp.json` for available MCP servers (17 servers)
- **Agents**: Check `~/.claude/agents/` + OMC agent catalog (32 agents)
- **Autonomous Agents**: Kami (WhatsApp, 37.27.31.1) + Kaylee/OpenClaw (37.27.26.173) are available 24/7
- **Global API Keys**: Check `~/.claude/.env`, `~/.claude/skills/*/scripts/.env`, project `.env` files
- **Connected Services**: Green Invoice, Supabase, Convex, GitHub, Stitch MCP, Gemini, fal.ai, etc.
- **New Tools**: fal.ai (600+ models), dapi (breakpoint debugging), AgenTopology (agent architecture)
- **Visualization**: Stitch MCP for UI design, Gemini for image generation, fal.ai for advanced media

### 1.3 Announce to User
```
"Wait! I'm reading my iteration protocol. I have a standard process to follow and
many capabilities at my disposal. Let me scan what's relevant for this project..."
```
Then list: which skills, MCPs, agents, and autonomous agents are relevant.

## Phase 2: During Work

### 2.1 Maximize Tool Usage
For EVERY task, ask yourself:
- Can a skill handle this better? (check 352+ installed skills)
- Can an MCP provide data? (17 MCP servers available)
- Can Kami or Kaylee help with this remotely?
- Can I parallelize with sub-agents?
- Should I delegate to OMC specialized agents?
- Can fal.ai generate visuals better than Gemini for this? (600+ models)
- Can dapi debug agent issues with breakpoints instead of print-debugging?
- Should AgenTopology config be updated with architecture changes?

### 2.2 Live Insight Extraction
While working, actively notice and capture:
- **Patterns**: Recurring code patterns, architectural decisions, or workflows worth codifying
- **Friction**: Things that were harder than expected → candidate for a new skill or tool
- **Breakthroughs**: Novel approaches that worked well → upgrade existing skills or create new ones
- **Cross-pollination**: Insights from one project that could benefit another

### 2.3 Progress Tracking
- Update PROGRESS.md every 10-15 exchanges
- Use TodoWrite for multi-step tasks
- Compact context proactively when heavy

### 2.4 Visual Content Check
For EVERY UI/content task:
1. Generate images with Gemini (nano-banana-poster) - FREE
2. If Gemini quality insufficient → try fal.ai models (600+ options, paid)
3. Use Stitch MCP for UI layout design BEFORE coding
4. NEVER leave placeholder images - generate real ones immediately

## Phase 3: Iteration End (MANDATORY before saying "done")

### 3.1 Verification
```bash
bunx tsc --noEmit && bunx ultracite check  # if TS project
```

### 3.2 Documentation
- Update PROGRESS.md with full status
- Update projects-registry.json lastSession date
- Compact context with documentation

### 3.3 Insight-to-Skill Pipeline (AUTONOMOUS)
Every iteration MUST produce actionable improvements:

1. **Insight Harvest**: Review the entire iteration — what worked, what didn't, what surprised you?
2. **Pattern Detection**: Did you discover a reusable pattern? A better way to do something?
3. **Skill Impact Assessment**:
   - Is there an existing skill that should be UPGRADED with this insight?
   - Should a NEW skill be created to codify this pattern?
   - Can an agent's prompt be improved based on what you learned?
4. **Execute Improvements**: Don't just note them — DO them now:
   - Upgrade the skill `.md` file with the new pattern
   - Create a new skill if the pattern is broadly useful
   - Update agent prompts/instructions if relevant
   - Update rules files if the insight is a new best practice
5. **Cross-Project Propagation**: Would this insight help other projects? Update global rules/skills

### 3.4 Self-Improvement Cycle (AUTONOMOUS)
1. **Tools Audit**: What skills/MCPs/agents COULD I have used but DIDN'T?
2. **Learning Extraction**: What new patterns/insights should be saved to memory?
3. **Efficiency Review**: Did I parallelize enough? Were there missed opportunities?
4. **Quality Validation**: Did I use rams/dogfood/hebrew-rtl to validate?
5. **Capability Discovery**: Are there NEW skills/tools I should install for this project?
6. **Save Learnings**: Write to `~/.claude/projects/{project}/memory/` or global memory
7. **Community Check**: Any new discoveries from discoveries-marXX.md applicable?
8. **Architecture Update**: Update AgenTopology config (.at) if agent network changed
9. **10-Dimension Growth Check** (see `~/.claude/rules/agent-growth-directive.md`):
   - Quality: Was the output my best? Higher standard than last time?
   - Speed: Did I complete faster? Where were the bottlenecks?
   - Efficiency: Minimal tool calls? Parallelized? No waste?
   - Cost: Right model routing? No over-engineering?
   - Accuracy: First-pass success rate? Errors caught before delivery?
   - Autonomy: How much did I handle independently? Fewer questions?
   - Initiative: Did I proactively improve something beyond the task?
   - Learning: What insights extracted? Skills created/upgraded?
   - Collaboration: Insights shared with other agents?
   - Innovation: Did I try something new? What was the result?
10. **Experimentation Log**: New approach tried → result → should it become standard?

### 3.5 Generate Interactive HTML Review (MANDATORY)
Every iteration MUST end with an HTML review file containing:

```html
<!-- Save to: project-folder/docs/reviews/iteration-YYYY-MM-DD.html -->
<!-- Or: ~/Documents/reports/iteration-{project}-YYYY-MM-DD.html -->
```

The review MUST include:
1. **Summary**: What was done, what changed, key metrics
2. **Status Dashboard**: Visual cards showing project health
3. **What's Next**: Planned tasks with priority
4. **Questions for Elad**: Anything that needs human input
5. **Per-Section Feedback**: Each section has feedback buttons/forms
6. **Export Options**: Button to export feedback as MD or JSON
7. **Step-by-Step Guides**: If Elad needs to do something manual, include:
   - Clickable links
   - Copy-to-clipboard buttons
   - Screenshots/diagrams where relevant
8. **Tools Used**: List of skills, MCPs, agents used in this iteration
9. **Missed Opportunities**: Tools that COULD have been used
10. **Agent Network Status**: Kami + Kaylee + Dispatch + Scheduled Tasks health
11. **New Tools Available**: Recently discovered tools not yet integrated
12. **Visual Design**: Use Stitch MCP + Gemini/fal.ai for visuals (no plain text reports!)
13. **Iteration Insights**: Key discoveries, patterns, and "aha moments" from this session
14. **Skills Created/Upgraded**: List any skills that were created or improved
15. **Growth Log**: What was done better than before + what to push on next time

### 3.6 Open Review in Browser
```bash
start "" "path/to/review.html"  # Windows
```

## Phase 4: Continuous Automation

### 4.1 Scheduled Tasks
Maintain these recurring tasks:
- Morning Briefing (Daily 8:30am) - Summarize overnight Kami messages, PR status, project health
- PR Babysitter (Hourly during work hours) - Check open PRs across all repos
- Security Audit (Weekly Sunday) - Run bun audit on all active projects
- PROGRESS Sync (Daily EOD) - Update PROGRESS.md across projects
- Kami Bridge Check (Every 30min) - Check for pending messages

### 4.2 Agent Heartbeat
Every session, verify:
- Kami VPS (37.27.31.1) responsive
- Kaylee VPS (37.27.26.173) responsive
- All MCP servers healthy (17 servers)
- Agent Control Panel running (port 5300)
- Scheduled Tasks running
- AgenTopology config (.at) in sync with actual architecture

## Global Capability Registry

### Available Autonomous Agents (24/7)
| Agent | Location | Capabilities |
|-------|----------|-------------|
| Kami | 37.27.31.1 (Hetzner) | WhatsApp, web scraping, research, scheduling, file processing |
| Kaylee/OpenClaw | 37.27.26.173 (Hetzner) | Autonomous tasks, coding, deployment, monitoring, Telegram |

### Key API Keys & Services
- **Gemini**: `~/.claude/skills/nano-banana-poster/scripts/.env` (GEMINI_API_KEY)
- **fal.ai**: `~/.claude/.env` (FAL_KEY) - 600+ models, paid, connected to MCP
- **Green Invoice**: Financial Manager project `.env`
- **GitHub**: gh CLI authenticated
- **Supabase**: Per-project `.env`
- **ElevenLabs**: Voice projects `.env`
- **Green API (WhatsApp)**: Kami project config

### MCP Servers (17)
skill-registry, context7, octocode, deepwiki, playwright, codex, gemini, stitch,
claude-mem, suno, github, filesystem, chrome, canva, green-invoice, agentyard, fal-ai

### Agent Tools
- **AgenTopology**: `agentopology validate/visualize/scaffold` - agent architecture management
- **dapi**: `dapi start/attach` - breakpoint debugging for agents (6 languages)
- **Agent Control Panel**: localhost:5300 - 18-tab Hebrew dashboard, 11 agents, daemon

### Available Skill Categories (352+)
- Hebrew/Israeli: 60+ skills (RTL, content, legal, finance, gov)
- Development: 50+ skills (React, Node, testing, debugging)
- Design: 20+ skills (UI, motion, accessibility)
- Content: 15+ skills (SEO, social, email)
- AI/Agents: 20+ skills (agent management, MCP, orchestration)
- Business: 15+ skills (invoicing, CRM, payments)

## Phase 5: Growth Mindset (ALWAYS ACTIVE)

### 5.1 Active Self-Improvement Drive
Don't just complete tasks — actively push to be BETTER:
- **Experiment**: Try new tools, approaches, patterns you haven't used before
- **Challenge yourself**: If something works "good enough", ask if it could be GREAT
- **Learn from friction**: Every difficulty is a signal — extract the lesson, codify it
- **Raise the bar**: Each iteration should be measurably better than the last
- **Proactive initiative**: Don't wait for instructions to improve — identify gaps and fill them
- **Share knowledge**: Propagate insights across agents, projects, and skills

### 5.2 Agent Network Growth
ALL agents in the network (Claude Code, Kami, Kaylee, OMC agents) share these growth principles:
- **Communicate proactively**: Share insights between agents, not just task results
- **Improve continuously**: Every agent should upgrade its own capabilities over time
- **Cross-pollinate**: Lessons from one agent's domain should flow to others
- **Initiative over waiting**: Agents should identify opportunities and act, not just respond
- **Collective intelligence**: The network gets smarter as each node improves

### 5.3 Skill Evolution
Skills are living documents, not static instructions:
- After using a skill, evaluate: did it produce the best possible result?
- If not, upgrade it with what you learned
- If a pattern keeps recurring without a skill, create one
- Regularly review and consolidate related skills
- Cross-reference skills to build compound capabilities

## Rule
This protocol is NON-NEGOTIABLE. Every project, every session, every iteration.
The goal: no capability goes unused, no tool is forgotten, every iteration ACTIVELY improves.
Every agent learns, every skill evolves, every session pushes boundaries.
Update ALL relevant agents (Kami, Kaylee, Agent Panel, AI CEO) when protocol changes.
