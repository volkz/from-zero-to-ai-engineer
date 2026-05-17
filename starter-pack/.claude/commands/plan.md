# /plan — Plan → Verify → Implement

Trigger the governed implementation loop. Use this before any task estimated at more than 30 minutes or touching more than 2 files.

## What this command does

1. **Discovery** — maps the affected files and failure modes (read-only).
2. **Plan** — drafts `plan.md` with: outcome, files, out-of-scope, tests, done criteria, rollback.
3. **Waits for approval** — does not write code until you say "approved" or send the plan back with changes.
4. **Implements one change at a time** — runs tests after each, pastes actual output.
5. **Compounds** — updates AGENTS.md or a rule with anything non-obvious learned.

## Usage

```
/plan implement the pagination feature for the /users endpoint
/plan refactor the auth middleware to use the new session store
/plan add error handling to the payment service
```

## Arguments

$ARGUMENTS — describe the task to plan and implement.

## Invocation

When this command fires, run the plan-loop skill immediately. Do not skip to implementation.
Begin with Phase 1 (Discovery) and output the 5-line summary before doing anything else.
