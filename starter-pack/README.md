# Starter Pack — 5-Minute Setup

Everything you need to run AI as governed engineering infrastructure in a new or existing repo. Works with Cursor and Claude Code.

## What's included

| File | Purpose |
|------|---------|
| `AGENTS.md` | Repo manifest — the first thing every AI agent reads |
| `.cursorignore` | Prevents AI from reading secrets, fixtures, and generated artifacts |
| `.cursor/rules/repo-laws.mdc` | 3 starter rules scoped to your most common patterns |
| `.claude/skills/` | 2 starter skills (error-handling + planning) with progressive disclosure |
| `.claude/commands/plan.md` | `/plan` command — trigger the Plan → Verify → Implement loop |
| `.github/workflows/lint-ai-config.yml` | CI gate: lint AGENTS.md and SKILL.md on every PR |
| `scripts/bootstrap.sh` | Copies this starter pack into your existing repo |

## Setup

```bash
# Option A: Fork from zero
git clone https://github.com/<your-username>/from-zero-to-ai-engineer
cp -r starter-pack/ /path/to/your-project/

# Option B: Bootstrap into an existing repo
cd /path/to/your-project
bash /path/to/from-zero-to-ai-engineer/starter-pack/scripts/bootstrap.sh
```

## After setup

1. Open `AGENTS.md` and fill in the `[FILL IN]` sections (project name, tech stack, key commands).
2. Open `.cursor/rules/repo-laws.mdc` and replace the example glob with your real file patterns.
3. Run `agents-md-lint AGENTS.md` to confirm the manifest is valid.
4. Commit everything — `AGENTS.md`, rules, skills — with CODEOWNERS protection.

## Smoke test

Open Cursor or Claude Code in your repo and prompt:

```
What are the exact commands to run tests in this project?
```

If the AI answers from your AGENTS.md content (not from a guess), the manifest loaded correctly.

## Companion series

Each file here is introduced in detail in the blog series. Start at Post 01:
→ [From 0 to AI Engineer](../README.md)
