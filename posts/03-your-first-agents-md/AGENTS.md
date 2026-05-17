# AGENTS.md — [PROJECT NAME]

> The contract your AI agent reads before touching anything in this repo.
> Keep it honest. Keep it current. Review quarterly.

## Project

- **Name:** [FILL IN — e.g., "payments-api"]
- **Type:** [FILL IN — e.g., "REST API / NestJS / TypeScript"]
- **Runtime:** [FILL IN — e.g., "Node 20.x"]
- **Package manager:** [FILL IN — "yarn" | "npm" | "pnpm" — pick one, document it here]

## Exact commands

> These must be copy-pasteable from the repo root. No "see the README" shortcuts.

```bash
# Install dependencies
[FILL IN — e.g., yarn install]

# Build
[FILL IN — e.g., yarn build]

# Run unit tests
[FILL IN — e.g., yarn test]

# Run integration tests (requires real infra — Docker or running DB)
[FILL IN — e.g., yarn test:integration]

# Lint
[FILL IN — e.g., yarn lint]

# Type check (without emitting)
[FILL IN — e.g., yarn tsc --noEmit]
```

## Project structure

```
[FILL IN — paste the output of: find . -maxdepth 2 -type d | grep -v node_modules | sort]

# Example for NestJS:
# src/
#   controllers/   HTTP layer only, no business logic
#   services/      Business logic, one service class per domain concept
#   dto/           Data transfer objects, never defined inline
#   entities/      Database entities / Prisma models
#   generated/     ← DO NOT TOUCH — owned by the code generator
# test/            Mirrors src/ directory structure
```

## Forbidden

> These are the rules that aren't obvious from reading the code.
> Add to this list when a rule is enforced by comment or verbal warning — move it here instead.

- Never use `[wrong package manager]` — this project uses `[correct package manager]`
- Never commit `.env`, `*.secret.*`, or `*.pem` files
- Never use `console.log` in production code — use `[your logger import path]`
- Never import from `src/utils` directly — use the barrel export at `src/utils/index.ts`
- Never touch `src/generated/` — owned by the code generator; your changes will be overwritten
- [FILL IN — add your team's non-obvious rules here, one per line]

## Key conventions

> Patterns that apply across the codebase. If a PR violates these, it will be sent back.

- [FILL IN — e.g., "All errors thrown in services must extend AppException, never plain Error"]
- [FILL IN — e.g., "DTOs must live in src/dto/, never defined inline in controllers"]
- [FILL IN — e.g., "gRPC methods must throw RpcException, not AppException"]
- [FILL IN — e.g., "Test files must be co-located with source: foo.service.spec.ts next to foo.service.ts"]

## External links

- Architecture decisions: [FILL IN — ADR folder or wiki link]
- CI/CD pipeline: [FILL IN]
- Issue tracker: [FILL IN]
- Design system (if frontend): [FILL IN]

## Runtime expectations

> These are not style preferences. They are verification requirements.

- Integration tests must hit a real database — do not mock the DB layer
- A failing test must produce a non-zero exit code — never swallow test exits
- Before claiming any task complete: run the relevant test command and paste the actual terminal output
- One logical change per agent run — do not combine unrelated changes

## Maintenance

- Last reviewed: [DATE]
- Reviewer: [NAME OR HANDLE]
- Next review: [DATE + 3 months]

---

## Adaptation notes

**Python projects:** Replace the commands block with `pip install -e ".[dev]"` / `pytest` / `ruff check .` / `mypy .`. The forbidden and conventions sections are language-agnostic — keep them.

**Go projects:** Replace with `go mod download` / `go test ./...` / `golangci-lint run`. Structure section should list the main packages.

**Monorepo:** This root AGENTS.md covers defaults. Create `packages/[name]/AGENTS.md` for package-specific overrides — only document what differs from root defaults.
