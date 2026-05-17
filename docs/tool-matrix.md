# Tool Parity Matrix

This matrix maps each concept from the series to its equivalent in the four most common AI coding tools. Use it to adapt examples to your tool of choice.

| Concept | Cursor | Claude Code | GitHub Copilot | Aider |
|---------|--------|-------------|----------------|-------|
| **Repo manifest** | `AGENTS.md` (root) | `AGENTS.md` (root) | — (no native equivalent) | — |
| **Always-load governance** | `.mdc` rule with `alwaysApply: true` | Skill with `trigger: always` | — | — |
| **Glob-scoped rule** | `.cursor/rules/*.mdc` with `globs:` | Skill scoped via description | — | — |
| **Semantic-triggered rule/skill** | `.mdc` with `description:` trigger | `.claude/skills/*/SKILL.md` | — | — |
| **Slash command / workflow** | No native equivalent (use rule) | `.claude/commands/*.md` | — | `/ask`, `/code` |
| **MCP tool registration** | `~/.cursor/mcp.json` | `~/.claude/mcp.json` | — | `--mcp-server` |
| **Mode: read-only exploration** | Ask mode (Ctrl+K) | Default (no tools) | Chat mode | `--no-auto-commits` |
| **Mode: planning** | Cursor Plan mode | Claude Code plan mode | — | — |
| **Mode: autonomous execution** | Cursor Agent mode | Claude Code agent mode | Workspace agent | `--auto-commits` |
| **Ignore file (agent vision)** | `.cursorignore` | `.claudeignore` | `.copilotignore` | `.aiderignore` |
| **Folder-level override** | Nested `AGENTS.md` | Nested `AGENTS.md` | — | — |
| **Multi-agent orchestration** | Composer (basic) | Subagents via Agent tool | — | Multi-model flag |
| **Hooks / pre-post callbacks** | — | `.claude/settings.json` hooks | — | — |

## Notes

- **Cursor** and **Claude Code** both follow the Agentic AI Foundation standards (AGENTS.md, MCP). Other tools are catching up.
- **GitHub Copilot** has no native AGENTS.md support as of series launch (2026); check for updates.
- **Aider** works primarily via CLI flags; MCP support is experimental.
- For posts that show Cursor examples, the Claude Code equivalent (or vice versa) appears in the same section. This matrix carries the full parity load.

Last verified: 2026-05-17
