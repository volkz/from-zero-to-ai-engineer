# plan.md — Task Plan Template

Copy this file into your repo root at the start of any non-trivial task.
Fill in before the agent writes a single line of production code.

---

## Outcome

One sentence: what will be different when this is done?

## Files to touch

<!-- List every file the implementation will create, edit, or delete.
     If you don't know yet, that's a signal to run Discovery first. -->

| File | Change |
|---|---|
|  |  |

## Out of scope

<!-- At least one explicit boundary. Prevents scope creep mid-session. -->
-

## Tests / verification

<!-- What must pass for this to be complete? Be concrete: paste the exact
     test command, the lint check, the screenshot criterion. -->

- `yarn test --testPathPattern="<file>" --passWithNoTests`
- `yarn lint src/<path>`

## Definition of done

<!-- This is the gate the agent must clear before reporting complete.
     Copy the verification list above; the agent checks each item. -->

- [ ] Tests listed above pass with non-zero exit on failure
- [ ] No new lint warnings introduced
- [ ] PR diff matches the "files to touch" list — no unplanned changes

## Rollback

<!-- One sentence: how to undo this if it goes wrong after merge. -->

`git revert <commit-sha>` or feature-flag disable if behind a gate.

---

## Approve / send-back rubric

Before approving this plan, ask:

1. **Is the outcome concrete?** Can I tell just by reading it whether we succeeded?
2. **Is the file list complete?** Would an engineer unfamiliar with the codebase know
   what to touch without guessing?
3. **Is out of scope named?** At least one explicit boundary prevents the classic
   "while I was in here..." expansion.
4. **Is verification verifiable?** A test command > "it should work" > nothing.

If any answer is "no" — send back with a one-line note. Do not approve a plan you
can't verify.
