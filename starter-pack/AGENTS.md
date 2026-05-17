# AGENTS.md — [PROJECT NAME]

> This file is the single source of truth for any AI agent working in this repo.
> Every agent reads this first. Keep it honest, keep it current.

## Project

- **Name:** [FILL IN — e.g., "my-api"]
- **Type:** [FILL IN — e.g., "REST API / NestJS / TypeScript"]
- **Runtime:** [FILL IN — e.g., Node 20, Python 3.12]
- **Package manager:** [FILL IN — e.g., "yarn" or "npm" or "pnpm" — pick one, never mix]

## Exact commands

```bash
# Install
[FILL IN — e.g., yarn install]

# Build
[FILL IN — e.g., yarn build]

# Test (unit)
[FILL IN — e.g., yarn test]

# Test (integration — requires infra)
[FILL IN — e.g., yarn test:integration]

# Lint
[FILL IN — e.g., yarn lint]

# Type check
[FILL IN — e.g., yarn tsc --noEmit]
```

## Project structure

```
[FILL IN — paste the output of: find . -maxdepth 2 -type d | sort | head -30]
```

## Forbidden patterns

- Never use `npm` if the package manager above is `yarn` (and vice versa).
- Never commit `.env` or files matching `*.secret.*`.
- Never use `console.log` in production code — use the project logger.
- [FILL IN — add your team's non-obvious rules here]

## Key conventions

- [FILL IN — e.g., "All errors thrown in service layer must extend AppException"]
- [FILL IN — e.g., "DTOs live in `src/dto/`, never inline"]
- [FILL IN — e.g., "gRPC methods must return RpcException, not plain Error"]

## External links

- CI/CD: [FILL IN]
- Issue tracker: [FILL IN]
- Architecture decision log: [FILL IN]

## Runtime expectations

- Tests must pass with a real database (do not mock DB calls in integration tests).
- A failing test must produce a non-zero exit code — no swallowing exits.
- Before claiming any task complete, run the test suite and paste the actual output.

## Maintenance

Last reviewed: 2026-05-17
Reviewer: [FILL IN]
Next review: 2026-08-17 (quarterly)
