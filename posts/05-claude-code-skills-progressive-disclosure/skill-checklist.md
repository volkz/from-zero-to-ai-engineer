# Skill Self-Review Checklist

Run this before merging any new or updated `SKILL.md`.

## Before opening the PR

- [ ] **1. Description triggers on real task language.**
  Open a fresh session and type a representative task ("Add error handling to the payment
  gRPC handler"). Confirm the skill activates (the agent's response uses skill-specific
  patterns, not generic ones). If it doesn't fire, rewrite the description to include words
  that appear in actual task messages.

- [ ] **2. Body is under 5,000 tokens.**
  Paste the body into a word counter. Rough estimate: 5,000 tokens ≈ 3,750 words ≈ ~200
  lines of dense code. If you're over, split into two skills by scenario (HTTP errors vs
  gRPC errors, not one god-skill).

- [ ] **3. No step-by-step team rituals in the body.**
  Procedures like "run this linter, then commit, then open the PR" belong in a Command
  (`/your-command`), not a Skill. A Skill provides expertise; a Command enforces workflow.
  If the body contains numbered checklists of team-wide steps, extract them to a Command
  and reference it from the Skill.

- [ ] **4. One scenario per skill.**
  If the body covers two distinct domains (e.g., HTTP error handling AND database retry
  logic), split it. Skills should have a single, clear trigger. If you can't write a
  one-sentence description without "and", it's two skills.

- [ ] **5. Verification step at the end.**
  Every Skill should tell the agent how to confirm the work is correct — a test command,
  a grep check, a manual smoke test. Without it, the agent narrates completion instead
  of proving it. See the error-handling Skill in this folder for an example.

- [ ] **6. Named owner in CODEOWNERS.**
  Add the skill path to your CODEOWNERS file:
  ```
  .claude/skills/error-handling/   @your-team/platform-ai
  ```
  Without ownership, skills accumulate untended. Ownerless skills are the first thing
  that goes stale when the underlying patterns change.

## Quarterly maintenance

- Re-run the activation probe — does the description still match real task language?
- Does the body reflect the current canonical pattern? (Check the pattern files it references.)
- If the skill has had zero activations in a quarter: archive it, don't delete (the
  decision to retire is as useful as the original skill).
