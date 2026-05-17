# From 0 to AI Engineer

A 12-post field guide for engineers who have outgrown chat-window AI and want to ship like the assistant is real infrastructure: governed, versioned, verifiable.

**Series by [David Gracia](https://delacruzd93@gmail.com)** — Principal Engineer, AI Engineering

---

## The Series

| # | Post | Level | Artifact |
|---|------|-------|----------|
| 00 | Why I'm writing this series | All | — |
| 01 | [The Blank Chatbox Trap](posts/01-blank-chatbox-trap/) | Junior | 5-question self-audit |
| 02 | [Why Prompts Aren't Programs](posts/02-prompts-arent-programs/) | Junior | Context Budget Card |
| 03 | [Your First AGENTS.md](posts/03-your-first-agents-md/) | Junior → Mid | AGENTS.md skeleton + PR checklist |
| 04 | [Cursor Rules That Survive Review](posts/04-cursor-rules-survive-review/) | Junior → Mid | `grpc-patterns.mdc` + Skill scaffold |
| 05 | [Claude Code Skills & Progressive Disclosure](posts/05-claude-code-skills-progressive-disclosure/) | Mid | Full SKILL.md + checklist |
| 06 | [Context Engineering in Practice](posts/06-context-engineering-in-practice/) | Mid | Pre-Flight card + session template |
| 07 | [Wiring an MCP Tool](posts/07-wiring-an-mcp-tool/) | Mid | ~80-line MCP server + registration snippets |
| 08 | [Plan → Verify → Implement](posts/08-plan-verify-implement/) | Mid | `plan.md` template |
| 09 | [Multi-Agent Review](posts/09-multi-agent-review/) | Mid → Senior | Review Agent Pack (5 agents + schema) |
| 10 | [Test-Driven AI (RED → GREEN)](posts/10-test-driven-ai/) | Mid → Senior | CONTRACT envelope + pre-commit hook |
| 11 | [Governance at Team Scale](posts/11-governance-at-team-scale/) | Senior | Governance Rollout Plan |
| 12 | [The AI Dividend, Measured](posts/12-the-ai-dividend/) | Senior | Quarterly AI Dividend Scorecard |

**First time here?** Start with Post 01 and grab the [starter pack](starter-pack/).

---

## Starter Pack

Clone-and-go governance bundle — AGENTS.md, 3 starter rules, 2 starter skills, a plan command, and CI lint. Works with Cursor and Claude Code.

```bash
# Fork this repo, then:
cd starter-pack
bash scripts/bootstrap.sh
```

See [`starter-pack/README.md`](starter-pack/README.md) for the 5-minute setup.

---

## License

- **Code** (everything in `starter-pack/`, `posts/**/mcp/`, `posts/**/tdd-harness/`, `*.sh`, `*.yml`): [MIT](LICENSE)
- **Prose** (posts, docs, READMEs): [CC BY 4.0](LICENSE)

---

## Contributing

Typos and broken examples: welcome. Thesis-altering PRs: not the right venue — open a discussion instead. Vendor-neutrality is required; all examples must generalize beyond a single tool. See [CONTRIBUTING.md](CONTRIBUTING.md).
