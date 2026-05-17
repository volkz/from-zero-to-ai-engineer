---
name: plan-loop
description: "Runs the Plan → Verify → Implement loop for any non-trivial coding task. Fires on: 'implement', 'build', 'add feature', 'refactor', 'create', when the task involves more than 2 files or is estimated at more than 30 minutes."
trigger: semantic
version: 1.0.0
owner: "[FILL IN]"
last_reviewed: 2026-05-17
---

# Plan → Verify → Implement Loop

Before writing a single line of code, complete phases 1 and 2.

## Phase 1 — Discovery (read-only)

Map the affected territory without changing anything:
- Which files will be touched?
- What are the entry points and boundaries?
- Are there existing tests? What do they cover?
- What are the failure modes?

Output: a 5-line summary of what you found. Stop. Do not proceed until the user reads it.

## Phase 2 — Plan

Write a `plan.md` in the working directory (or current folder if no obvious home):

```markdown
## Outcome
[One sentence: what will be true when this is done]

## Files to touch
- path/to/file.ts — what changes and why
- path/to/test.ts — what tests will be added/changed

## Out of scope
- [Explicit list of things you are NOT doing]

## Tests
- [Exact test names or describe blocks you will add/change]

## Done when
- [ ] All named tests pass with non-zero exit on failure
- [ ] lint passes
- [ ] types check

## Rollback
[One command or action to undo everything in this plan]
```

Propose the plan. Do not write code until the user approves or sends the plan back with changes.

## Phase 3 — Implement

- Implement one logical change at a time, as specified in the plan.
- After each change, run the relevant test command and paste the actual output.
- Do not move to the next change until the current one is green.

## Phase 4 — Compound

If you learned anything non-obvious during implementation, update AGENTS.md or add a rule/skill so the learning persists.

## When the model resists this loop

If the AI says "let me just write the code" — invoke this skill explicitly and repeat Phase 1.
