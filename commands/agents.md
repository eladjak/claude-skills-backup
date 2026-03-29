---
description: List and run available agents
---

Show available agents and their purposes.

## Available Agents

### Development
| Agent | Purpose | Model |
|-------|---------|-------|
| `planner` | Implementation planning | inherit |
| `code-reviewer` | Code review | inherit |
| `component-builder` | Build components | inherit |
| `bug-investigator` | Investigate bugs | inherit |

### Testing & Quality
| Agent | Purpose | Model |
|-------|---------|-------|
| `test-runner` | Run tests, analyze failures | haiku |
| `integration-verifier` | Verify integrations | inherit |
| `silent-failure-hunter` | Find silent failures | inherit |

### Documentation
| Agent | Purpose | Model |
|-------|---------|-------|
| `doc-generator` | Generate docs from code | haiku |

### Performance & Security
| Agent | Purpose | Model |
|-------|---------|-------|
| `performance-profiler` | Profile performance | haiku |
| `dependency-checker` | Audit dependencies | haiku |
| `api-tester` | Test API endpoints | haiku |

### Migration
| Agent | Purpose | Model |
|-------|---------|-------|
| `migration-helper` | Help with upgrades | sonnet |

## Usage

Agents are invoked via Task tool:
```
Task(subagent_type="<agent-name>", prompt="...")
```

## Tips

- Use **haiku** agents for quick tasks (faster, cheaper)
- Use **sonnet** agents for complex reasoning
- Run independent agents in **parallel**
- Agents return results - summarize for user
