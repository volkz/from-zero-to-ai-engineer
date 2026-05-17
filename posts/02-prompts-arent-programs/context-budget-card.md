# Context Budget Card

*From 0 to AI Engineer — Post 02 artifact*
*Keep this open during any AI coding session.*

---

## Budget rules

| Fill level | Status | Action |
|-----------|--------|--------|
| 0–40% | Green — full attention | Normal operation |
| 40–60% | Yellow — attention degrading | Trim history, remove low-signal @s |
| 60%+ | Red — instructions falling apart | Reset: new chat + fresh anchor set |

**Reset ritual:** New chat → 3 sentences of context → re-attach the 3 essential files → continue.

---

## What to @ (spend on signal)

**Always worth it:**
- The file you're editing right now
- The reference implementation for the pattern you're following
- The relevant test file
- AGENTS.md loads automatically — it's paid for

**Worth it if relevant:**
- The DTO / schema / proto definition for what you're building
- One similar feature as a reference
- The canonical error handling file

**Rarely worth it:**
- Entire directories
- Generated output pasted back in
- Documentation (unless it's your actual API contract)
- Long conversation history past ~10 turns

---

## Pre-session checklist (before any non-trivial Agent run)

- [ ] Success criteria stated (tests, behavior, non-goals)
- [ ] Canonical files @-referenced (no whole-directory dumps)
- [ ] `.cursorignore` / `.claudeignore` keeps secrets and build artifacts out
- [ ] Context bar isn't already maxed from unrelated work
- [ ] Plan approved if touching more than 2–3 files

---

## Mode picker

| Situation | Mode |
|-----------|------|
| Reading, tracing, understanding the codebase | Ask / read-only |
| Multi-file feature, unclear what files to touch | Plan — approve before edits |
| Bounded implementation with clear done criteria | Agent / execution |

**Rule:** Never enter execution mode without an approved plan and a stated definition of done.

---

## When output drifts

1. Stop. Do not patch in the same thread.
2. Revert the AI's changes (CMD+Z to last good state).
3. Fix the briefing: clearer scope, better @s, add a rule for the constraint.
4. Open a new chat. Re-anchor.
5. Run the improved briefing from scratch.

---

*Companion repo: `posts/02-prompts-arent-programs/context-budget-card.md`*
