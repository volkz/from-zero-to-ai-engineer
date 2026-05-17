# Context Engineering Pre-Flight Card

Run this before any non-trivial agent session (anything over ~2 files or ~30 minutes).

---

## 5-Item Pre-Flight

- [ ] **1. Done is defined.**
  State "done" in one verifiable sentence: a test command that passes, a screenshot of
  the rendered component, a metric that moves. If you can't state it, the model can't
  finish — it will keep going until it runs out of context.

- [ ] **2. Anchors are selected.**
  Choose 2–4 files that represent the boundary of the work: a similar existing feature,
  the relevant DTO or contract, and the test file. These are the @ references you open
  the session with. More is not better — precision is leverage.

- [ ] **3. Context bar is clean.**
  Start a fresh session. Do not carry yesterday's chat into today's task. A session
  already at 40%+ context usage before you type a word is a context tax on your work.
  The 40/60 guideline: attention starts slipping at 40%, multi-step instructions fall
  apart at 60%.

- [ ] **4. Governance is loaded.**
  Does the task involve a specific domain (gRPC, database, auth)? Check whether the
  relevant Skill will fire automatically. If not, @-reference the canonical file or rule
  explicitly. Don't rely on the model's training knowledge for org-specific patterns.

- [ ] **5. Out-of-scope is named.**
  In your first message, state one thing the session should NOT touch. This prevents
  the model from expanding scope when it reaches a related concern mid-task.
  "Do not modify the auth middleware — that is out of scope for this session."

---

## Mode Picker

| Task type | Start in | Notes |
|---|---|---|
| Understanding / mapping | Ask | Read-only; map before touching |
| Multi-file feature / refactor | Plan | Generate plan.md; wait for approval |
| Bounded execution, clear spec | Agent | Scope defined; governance loaded |

---

## Reset Ritual (when to call it)

If any of these appear mid-session: wrong library era, mixed patterns, model "forgot" a
constraint set five turns ago, or the diff looks like it rewrote the world.

1. Stop. Do not patch inline.
2. Undo the AI's changes (restore last good state — CMD+Z / `git checkout`).
3. Open a new session.
4. Re-run pre-flight with clearer anchors.
5. State what went wrong in the first message of the new session as a constraint.
