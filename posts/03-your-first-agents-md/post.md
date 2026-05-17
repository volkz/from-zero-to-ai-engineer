# Your First AGENTS.md: The Contract Your Repo Has Been Missing

**by David Gracia — Principal Engineer, AI Engineering**

> Part 3 of 12 in *From 0 to AI Engineer*.
> ← Previous: [Post 2 — Why Prompts Aren't Programs](../02-prompts-arent-programs/post.md)
> → Next: [Post 4 — Cursor Rules That Survive Review](../04-cursor-rules-survive-review/post.md) (publishes in 2 weeks)
> First time here? Start with Post 1 and this post (the starter pack begins here).
> Companion code: [from-zero-to-ai-engineer](https://github.com/volkz/from-zero-to-ai-engineer)

---

**One-line hook:** *A 60-line Markdown file that pays for itself in the first PR. Here's how to write one for an existing codebase without breaking anything.*

---

## The tribal knowledge trap

Every codebase has unwritten rules. Some live in a senior engineer's head. Some survive only in Slack threads. Some exist solely in the muscle memory of whoever set up CI six months ago.

"We use Yarn not npm here." "Never import from `utils/` directly — use the barrel export." "Tests require the `--runInBand` flag or they race against each other." "That folder is read-only — the code generator owns it."

When a new engineer joins, they spend their first two weeks mining this knowledge through accidental violation. They run npm, get a confusing error, ask a Slack channel, learn Yarn. They import the wrong file, get a review comment, learn the barrel pattern. The onboarding tax is paid in mistakes.

This is the Tribal Knowledge Trap. Your AI assistant is the world's fastest new engineer — and it has the same problem. It will npm when you meant yarn, import wrong files, skip flags that matter, step on generated code. Not because it can't do better, but because nobody told it the rules.

AGENTS.md is the solution to this. Not the complete solution — we'll build out the full governance layer across posts 3–5. But AGENTS.md is the foundation: the one file every AI agent reads before it does anything.

---

## What AGENTS.md is (and isn't)

AGENTS.md is a Markdown file at the root of your repository that defines the rules of engagement for any AI agent working in that codebase. It answers the questions a capable new engineer would ask on day one: How do I build this? How do I run the tests? What can't I touch? What patterns does this codebase use?

It is now part of the Agentic AI Foundation — a Linux Foundation project that also stewards Anthropic's Model Context Protocol and Block's Goose. The standard is supported by Cursor, Claude Code, GitHub Copilot, OpenAI Codex, Google Gemini CLI, Devin, Factory, and VS Code, among others. Writing one AGENTS.md gives you consistent behavior across whichever tool your team uses.

Industry data (directional, treat as motivation): codebases with AGENTS.md see roughly 29% reduction in AI wall-clock runtime and 17% fewer output tokens consumed. The mechanism is straightforward — less time spent by the model inferring project structure, more time spent on the actual task. Over 60,000 open-source projects have adopted the standard as of early 2026.

**What AGENTS.md is not:** It is not a README. It's not documentation for humans, it's instructions for agents. Shorter, more precise, structured around what the model needs to do work — not what a human needs to understand the project. You don't need to explain why. You need to specify what.

---

## Anatomy in 60 lines

A good AGENTS.md covers six things: who this repo is, how to build and test it, what the structure looks like, what it must never do, where to find more information, and what "done" means when the agent is finishing a task.

Here's the skeleton — annotated so you understand each section's purpose:

```markdown
# AGENTS.md — [PROJECT NAME]

## Project
- Name: my-api
- Type: REST API / NestJS / TypeScript
- Runtime: Node 20
- Package manager: yarn  ← pick one, document it, never deviate

## Exact commands
# These must be copy-pasteable. No "see the docs" shortcuts.
- Install:    yarn install
- Build:      yarn build
- Test:       yarn test
- Test (int): yarn test:integration   ← separate command if infra required
- Lint:       yarn lint
- Type check: yarn tsc --noEmit

## Structure
src/
  controllers/   ← HTTP layer only, no business logic
  services/      ← Business logic, one class per domain concept
  dto/           ← Data transfer objects, never inline
  entities/      ← Database entities
test/            ← mirrors src/ structure

## Forbidden
- Never use npm (this project uses yarn)
- Never commit .env or *.secret.* files
- Never use console.log in production code — use the logger
- Never touch the src/generated/ folder — owned by the code generator
- Never import from src/utils directly — use barrel exports

## Links
- Architecture: [link to your ADR or design doc]
- CI/CD: [link to your pipeline]
- Issue tracker: [link]

## Runtime expectations
- Tests must hit a real database (no mocking DB layer in integration tests)
- A failing test must produce a non-zero exit code
- Before claiming any task complete, run tests and paste the actual output
```

That's under 60 lines. Each section earns its space: the commands prevent wrong assumptions about your toolchain; the structure tells the agent where things live; the forbidden list is where you encode the non-obvious rules that aren't inferable from reading the code.

The runtime expectations section is the one most teams skip, and the one that matters most. "Paste the actual output" is not a style preference — it's the verification gate that separates "looks done" from "is done."

---

## Bootstrap path for existing repos

You don't need to write this from scratch. For any existing repo, the knowledge is already there in three files:

1. **README.md** — extract the setup steps and commands
2. **package.json** (or `pyproject.toml`, `go.mod`) — the package manager and script names are explicit
3. **One CI workflow** (`.github/workflows/ci.yml` or equivalent) — the exact test and lint commands, the node version, any flags

Read those three files, fill in the template, and you have a first draft in under 30 minutes. It won't be perfect — you'll find gaps the first time an AI hits a rule you forgot to document. Add the missing rule and move on. AGENTS.md is a living document.

---

## Folder overrides

The root AGENTS.md defines defaults for the whole repo. But in a monorepo, a backend service has different rules than a frontend package. AGENTS.md supports folder-level overrides: a nested `AGENTS.md` in a subdirectory adds or narrows rules for that subtree.

Example: root `AGENTS.md` says `yarn test` and enforces Nest patterns. The `platform/bff/` package has its own runtime, its own test command, and BFF-specific transport rules. Create `platform/bff/AGENTS.md`:

```markdown
# AGENTS.md — platform/bff

## Overrides root defaults for this package

## Commands (BFF-specific)
- Test: yarn workspace @my-org/bff test --runInBand
- Build: yarn workspace @my-org/bff build

## BFF-specific constraints
- All HTTP responses must go through the ResponseInterceptor — never send raw objects
- Cache headers are set by the CacheMiddleware — never set Cache-Control manually
- Websocket handlers live in gateways/, not controllers/
```

You don't repeat the global rules — they still apply. You only add what's different. The nearest `AGENTS.md` wins for any file in that subtree.

**Precedence in one sentence:** Nearest AGENTS.md beats parent AGENTS.md beats project rules beats your prompt beats the base model's default behavior.

---

## Validating that it loaded

Before you commit your AGENTS.md and call it done, verify that the agent actually reads it. Open Cursor or Claude Code in your repo and prompt:

```
What are the exact commands to run tests in this project?
```

If the response comes from your AGENTS.md content — exact commands, correct flags, right package manager — the manifest loaded correctly. If the response is a guess ("probably npm test?"), something is wrong: the file might not be at the repo root, or the client might need restarting.

Run this smoke test after every significant change to the file.

---

## Reviewing it like code

Before you open the PR, run three checks:

**1. No secrets.** No API keys, no database connection strings, no internal URLs that shouldn't be public. AGENTS.md lives in version control. Anything you put in it is in your git history.

**2. No over-broad glob patterns.** If you're already adding rules (more on that in Post 4), avoid `**/*` applied to everything. That's a context tax you pay on every session. Scope rules to where they matter.

**3. Commands are copy-pasteable.** Every command in the Exact Commands section should run correctly when pasted into a terminal from the repo root. Test them before committing.

Put AGENTS.md under CODEOWNERS protection. Governance files — the things that shape how AI agents behave in your codebase — should require the same review as your main application code. One person sneaking in a "never write tests" rule is exactly the risk you're governing against.

---

## The honest maintenance cost

AGENTS.md is not set-and-forget. The commands change when you upgrade Node. The structure changes when you refactor. The forbidden list grows as you discover new tribal rules through incidents.

The practical answer is a quarterly review: 20 minutes, one engineer, against a checklist. Are the commands still correct? Has the structure changed? Are there new forbidden patterns that got added as code comments that should be here instead?

The artifact in the companion repo includes a 10-item PR checklist that covers both the initial AGENTS.md review and the quarterly maintenance pass.

---

## What it pays for

The first PR where your AI correctly uses Yarn instead of npm, follows the barrel import pattern, and runs tests with the right flags without being told — that's AGENTS.md paying for itself. The second one too. And the one after that.

The tribal knowledge trap isn't just a junior-onboarding problem. It's a compounding tax on every AI-assisted task, paid in corrections, re-runs, and review comments. AGENTS.md is a one-time investment that eliminates a whole category of mistakes permanently.

Post 4 goes one layer deeper: rules. AGENTS.md is the constitution — broad, project-wide truth. Rules are the laws for specific file patterns: glob-scoped invariants that fire only where they matter and enforce what AGENTS.md can only gesture at.

---

## Artifacts

In the companion repo:

- [`posts/03-your-first-agents-md/AGENTS.md`](AGENTS.md) — The annotated 60-line skeleton for Node/TS, with adaptation notes for Python and Go
- [`posts/03-your-first-agents-md/nested-override-example.md`](nested-override-example.md) — A worked example of folder-level override
- [`posts/03-your-first-agents-md/pr-checklist.md`](pr-checklist.md) — 10-item AGENTS.md PR review checklist

The starter pack at the repo root also includes a ready-to-use AGENTS.md template with fill-in-the-blank sections — `starter-pack/AGENTS.md`.

---

**Bio:** David Gracia is a Principal Engineer working on AI-native SDLC at BioCatch (fraud prevention, regulated fintech). Opinions are mine; examples generalized from a real production environment. The Medium piece that seeded this series: [Engineering the Prompt](https://medium.com/@BioCatchTechBlog/engineering-the-prompt-how-biocatch-architected-an-ai-native-sdlc-b4b8d512297f).
