# Why Prompts Aren't Programs: Context Is a Budget, Not a Scratchpad

**by David Gracia — Principal Engineer, AI Engineering**

> Part 2 of 12 in *From 0 to AI Engineer*.
> ← Previous: [Post 1 — The Blank Chatbox Trap](../01-blank-chatbox-trap/post.md)
> → Next: [Post 3 — Your First AGENTS.md](../03-your-first-agents-md/post.md) (publishes in 2 weeks)
> First time here? Start with Post 1 and Post 3 (the starter pack).
> Companion code: [from-zero-to-ai-engineer](https://github.com/volkz/from-zero-to-ai-engineer)

---

**One-line hook:** *Engineers treat prompts like functions. They aren't. Once you see context as a finite budget you spend on signal, everything else makes sense.*

---

## The programmer's reflex

Post 1 named the Blank Chatbox Trap: open a chat, describe what you want, paste the answer, call it engineering.

The obvious fix — the one almost every engineer reaches for — is to write better prompts. Longer. More specific. More detailed. If the output was wrong, the prompt must have been insufficiently precise.

This instinct makes perfect sense if prompts are like functions. With functions, more code can mean more correct. A 200-line function that handles all edge cases is better than a 10-line function that doesn't. So the programmer's reflex is: if the AI missed something, tell it more.

The problem is that prompts aren't programs. Context isn't a function body. And once the window fills, more context doesn't make the output better — it makes it worse.

---

## What context actually is

Here's what the model "sees" when you send a message:

- Everything in the conversation history (every message, every file you've pasted, every tool output)
- Every file you've @-referenced
- Every governance artifact that loads automatically (AGENTS.md, rules, skills)
- Your current message

All of this together is the context window. It's measured in tokens — the model's internal unit of text. A rough heuristic: about 4 characters per token, roughly 750 words per 1,000 tokens. Dense code costs more per line than prose.

The key thing to understand: the model cannot see anything outside this window. It doesn't have memory of previous sessions. It doesn't have access to your codebase unless you put the relevant pieces into the window. If a constraint, a pattern, or a rule isn't in that bundle, the model cannot "know" it.

This is why "write a better prompt" often fails. The issue isn't what you said — it's what's missing from what the model can see.

---

## Context is a budget

Here's the frame that makes everything else in this series click: **context is a finite budget, and every @ reference is a withdrawal.**

A typical context window holds somewhere between 100,000 and 200,000 tokens, depending on the model. That sounds enormous until you consider what you're spending it on:

- Your governance artifacts (AGENTS.md, rules): 1,000–5,000 tokens
- The current file you're working in: 500–5,000 tokens
- A similar feature for reference: another 1,000–5,000 tokens
- Conversation history after 10 turns: 5,000–20,000 tokens
- That log output you pasted: 2,000 tokens
- The entire `utils/` directory you @-ed without thinking: 15,000 tokens

You can see how quickly it fills. And crucially, a full context window is not a powerful context window. It's a noisy one.

Empirically, attention quality starts degrading around 40% fill for complex, multi-step tasks. Beyond 60%, multi-step instructions often fall apart — the model starts dropping earlier constraints, confusing files, losing track of what you asked. The model doesn't announce this. The output just drifts.

**The counterintuitive rule:** Less context, better focused, beats more context, broadly attached.

This is the opposite of the programmer's reflex. Not more — more precise.

---

## What you're actually buying with each @

Think of each @ reference as a deliberate purchase from a fixed budget. What's worth buying?

**High-signal, buy first:**
- The file you're actually editing
- A reference implementation for the pattern you're following
- The relevant test file
- Your AGENTS.md (loaded automatically — this is always worth its cost)
- The contract file (DTO, schema, proto definition) for the thing you're building

**Medium-signal, buy if you need it:**
- A related service you're integrating with
- The error handling pattern canonical file
- A specific past PR that solved a similar problem

**Low-signal, buy with caution:**
- Long conversation history (stale, noisy)
- Entire directories
- Generated output you pasted back in (you're spending budget to re-process your own artifacts)
- Documentation that's general rather than specific to your task

The discipline is spending on signal, not volume. Three well-chosen files beat twenty loosely relevant ones.

---

## The anti-patterns

Two failure modes show up constantly once you understand context as a budget.

**"@ the whole repo."** Engineers new to AI coding sometimes respond to bad output by adding more context — @-ing entire directories, every utility file, all the docs. This is the programmer's reflex applied to context: more = better. It doesn't work. The model's attention dilutes. It starts averaging across everything instead of applying the constraint you care about.

**"Keep this chat going all week."** A long-running chat thread is a context graveyard. Every tool output, every correction, every "actually, let's change direction" adds tokens that never leave. The model has to navigate around all of it to find the current intent. After enough turns, the signal-to-noise ratio inverts.

The reset ritual: roughly every 10–15 heavy exchanges, open a fresh chat. Take 3 sentences to re-establish context: what you're building, the relevant files, the current step. You don't lose anything important — you shed everything that was polluting attention.

---

## Modes as a forcing function

Most AI coding tools offer multiple modes. The names vary — Cursor calls them Ask, Plan, and Agent; Claude Code has similar concepts — but the pattern is consistent and worth understanding:

**Read-only exploration mode:** The model can examine your codebase but cannot edit. Use this when you're mapping territory — understanding what exists before you change it. This is the cheapest mode context-wise; it doesn't add tool outputs to the history.

**Planning mode:** The model proposes a plan — which files to touch, what changes to make, in what order — but does not execute it. You review and approve before any code is written. This is the mode that separates "I asked it to build something" from "I approved a specific plan and then it built it."

**Execution mode:** The model can read, edit, and create files. This is expensive — every tool call adds output to the context. Keep scope small. Enter this mode with clear success criteria already defined, not to figure out what success looks like.

These modes are a forcing function for context discipline. Planning mode prevents you from burning your whole context budget on an exploratory conversation and then trying to execute in the same session. Execution mode nudges you to define scope before committing budget.

---

## The budget in practice

Here's what disciplined context spending looks like for a concrete task: adding a paginated endpoint to an existing API.

**Bad (expensive, imprecise):**
```
@ the entire services/ directory
@ the entire dto/ directory  
@ package.json
@ README.md
"Add pagination to the users endpoint"
```
Context spend: ~25,000 tokens on mostly irrelevant material. The model averages across everything.

**Good (surgical, precise):**
```
@services/user.service.ts     (the file we're editing)
@dto/user.dto.ts              (the shape we're extending)
@services/product.service.ts  (an existing example of pagination)
"Add cursor-based pagination to getUserList(). 
 Follow the pattern in product.service.ts. 
 Output: updated DTO and service method only. 
 Do not touch the controller."
```
Context spend: ~4,000 tokens on directly relevant material. The model applies the right pattern to the right file.

The second version doesn't just perform better — it's also easier to review, because the diff is narrower. Disciplined context produces disciplined output.

---

## The closer

Better AI isn't longer prompts. It's owning the budget.

You are not waiting for the model to get smarter. You are deciding what it sees, in what order, at what level of detail. That is a skill — the same skill a good senior engineer applies when briefing a junior: here are the relevant files, here is the pattern to follow, here is what done looks like, here is what you must not touch.

The next question is: what if that briefing could load automatically, before you type a single word? That's what AGENTS.md does.

Post 3: how to write one in 60 lines that pays for itself in the first PR.

---

## Artifact

The [Context Budget Card](context-budget-card.md) is in the companion repo — a one-pager you can keep open during any AI coding session.

---

**Bio:** David Gracia is a Principal Engineer working on AI-native SDLC at BioCatch (fraud prevention, regulated fintech). Opinions are mine; examples generalized from a real production environment. The Medium piece that seeded this series: [Engineering the Prompt](https://medium.com/@BioCatchTechBlog/engineering-the-prompt-how-biocatch-architected-an-ai-native-sdlc-b4b8d512297f).
