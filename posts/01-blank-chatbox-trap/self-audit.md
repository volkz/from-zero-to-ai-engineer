# Blank Chatbox Self-Audit

*From 0 to AI Engineer — Post 01 artifact*

Answer each question for your current team workflow, today.

---

## 5 Questions

**1. Consistency**
If two engineers on your team run the same AI task right now — same feature, same repo — will they produce compatible output?

- [ ] Yes, we have a shared briefing artifact (AGENTS.md or similar) they both use
- [ ] Probably not — each person prompts differently
- [ ] We haven't thought about this

---

**2. Anchoring**
In your last AI-assisted PR, was the AI given specific file references — the actual service, the actual test file, the actual pattern to follow?

- [ ] Yes — I @-referenced the relevant files explicitly
- [ ] Partly — I mentioned the general area but not specific files
- [ ] No — I described what I wanted and let it find the files

---

**3. Written conventions**
Does your repo have a written document telling AI agents which commands to run, which patterns to follow, and what it must never do — something that loads automatically at the start of every session?

- [ ] Yes — AGENTS.md or equivalent, reviewed in the last 3 months
- [ ] Partially — there's something, but it's incomplete or outdated
- [ ] No

---

**4. Definition of done**
When you ask AI to implement something, how do you determine it's complete?

- [ ] A specific test runs and passes with a non-zero exit code on failure — I paste the output
- [ ] I review the diff and it looks correct
- [ ] The AI told me it was done

---

**5. When output is wrong**
When AI output is wrong or needs significant changes, what do you do?

- [ ] Start a fresh session with an improved briefing — revert, don't patch
- [ ] Fix the specific lines in the same thread and continue
- [ ] Accept it and fix it in a follow-up PR

---

## Scoring

Count your first-option answers (the A answers):

**4–5:** You've internalized the briefing mindset. Post 3 (AGENTS.md) will formalize what you're already doing intuitively.

**2–3:** You're aware of the problem but the workflow isn't systematic yet. Posts 1–4 will close the gap.

**0–1:** You're in the Blank Chatbox Trap. That's the right starting point — the staircase begins here.

---

*This artifact lives at `posts/01-blank-chatbox-trap/self-audit.md` in the companion repo.*
*Printable: paste into a doc, remove the markdown formatting.*
