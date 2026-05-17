# Glossary

**AGENTS.md** — A Markdown file at the root (or a subdirectory) of a repo that defines the rules of engagement for any AI agent working in that codebase. Part of the Agentic AI Foundation standard. Loaded automatically by Cursor and Claude Code. Precedence: nearest AGENTS.md > rules > prompt > base model.

**AIDLC** — AI Development Life Cycle. An engineering framework for treating AI assistance as governed, auditable infrastructure rather than ad-hoc chat. Phases: Discovery → Plan → Verify → Implement → Compound → Repeat.

**AX** — Agent Experience. The discipline of designing AI agent configuration (manifests, rules, skills, tools) for reliability, debuggability, and predictability — analogous to UX for humans.

**Context budget** — The finite space in an AI's context window, measured in tokens. Spent on: governance files, conversation history, attached files, tool outputs. Precision beats volume — fewer, higher-signal files outperform attaching everything.

**CONTRACT envelope** — A YAML artifact declaring what command was run, what output was expected, and what output was actually produced. Required before claiming any task complete. Prevents "looks right" shipping.

**Evidence-first** — The principle that a task is only complete when verifiable output (test results, lint output, actual terminal response) proves it — never when the AI narrates completion.

**MCP** — Model Context Protocol. An Anthropic protocol (now Agentic AI Foundation) that lets AI agents call tools — read databases, run commands, call APIs — in a structured, auditable way.

**Plan → Verify → Implement** — The three-phase loop that governs non-trivial implementation tasks: map first, define "done" before coding, implement in atomic slices.

**Progressive disclosure** — A three-level architecture for Skills: ~100 tokens of metadata always loaded (cheap), <5k tokens of full instructions loaded on match (medium), supporting resources loaded on demand (expensive). Described in Post 05.

**Rules (`.mdc`)** — Glob-scoped governance laws in Cursor format. Always or conditionally loaded based on which files are in scope. Short, absolute, non-negotiable. Complement to Skills, which are procedural.

**Skills** — Semantic playbooks for Claude Code (and the Cursor equivalent). Triggered by description match, not glob. Carry full procedure + supporting resources with progressive disclosure.

**Silent-failure hunter** — A specialized review agent whose only job is finding errors that don't surface as test failures: swallowed exceptions, assertions that never run, mocks that mask real behavior.

**Starter pack** — The governance bundle in this repo's `starter-pack/` directory: AGENTS.md, .cursorignore, 3 starter rules, 2 starter skills, a /plan command, and CI lint. Clone-and-go.

**Verification gate** — An explicit checkpoint before claiming completion. Enforced via CONTRACT envelope or by requiring non-zero exit code from a failing test before the task is considered done.
