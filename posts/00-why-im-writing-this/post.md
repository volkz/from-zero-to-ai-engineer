# Why I'm Writing This Series

**by David Gracia — Principal Engineer, AI Engineering**

---

I've been using AI coding tools in production for long enough to have made most of the mistakes. Not the shallow ones — not "it generated code with a bug." The structural ones. The ones where you look at a six-month-old codebase and realize the AI and the team have been having two different conversations.

That experience is what this series is about.

---

## What changed for me

A few years ago I treated my AI assistant the way most engineers still do: I opened a chat, described what I wanted, pasted the answer into the editor, moved on. It felt fast. It *was* fast, at first.

Then we started seeing the cracks. Inconsistent patterns across PRs that all "came from AI." Security assumptions that were generically correct but wrong for our environment. Context drift that turned a helpful assistant into a confused one three hours into a session. Review cycles that were slower, not faster, because the code looked plausible but wasn't grounded in anything we'd agreed on.

The fix wasn't to use less AI. The fix was to stop treating it as a chat window and start treating it as infrastructure.

That reframe — from chat to infrastructure — is the thread that runs through everything I'm going to write.

---

## What you'll find here

This is a 12-post field guide. The complete series title is *From 0 to AI Engineer*, and the staircase looks like this:

**Posts 1–4 (Junior):** We start from the beginning. Why AI feels unreliable. What context actually is and why it's a budget, not a scratchpad. How to write a 60-line Markdown file that makes your AI useful in an existing codebase in one afternoon. How to write governance rules that survive code review.

**Posts 5–10 (Mid-level):** We go hands-on. Progressive disclosure in AI skills. Context engineering as a discipline. Wiring an MCP tool so your agent can run your tests instead of just describing them. The Plan → Verify → Implement loop. Multi-agent review with five specialized reviewers and a tie-breaker. Test-driven AI with a failing test and a non-zero exit code as the only definition of done.

**Posts 11–12 (Senior / tech lead):** We zoom out. What it looks like to run AI as team infrastructure — versioned, reviewed, owned, measured. And how to report the AI dividend honestly, with bounded metrics and explicit trade-offs, to a VP who will ask why it matters.

Each post ships with a concrete artifact — a template, a working code snippet, a checklist — in the companion repo. You'll have something real to put in a PR, not just ideas to consider.

---

## Who I am and why this isn't just another "10x developer" take

I'm a Principal Engineer working on AI-native SDLC at BioCatch, a fraud prevention company working in regulated fintech. The ideas in this series are generalized from real production experience — a real environment, real constraints, real governance requirements, and real failures that taught me what matters.

I've also published one piece on this topic already, a team article titled *Engineering the Prompt: How BioCatch Architected an AI-Native SDLC* on Medium. That piece tells the story in corporate voice, with "we" throughout. This series is different: it's my voice, my opinions, my mistakes. BioCatch is the context, not the subject.

I'm writing this because the public discourse on AI coding is dominated by two extremes: breathless "AI wrote my entire startup" posts and cynical "AI is just autocomplete" dismissals. Neither is useful to an engineer who has to ship code that's correct, secure, and maintainable — and who wants AI to help with that, not complicate it.

I have a specific, opinionated view on how to do this well. That's what these twelve posts are.

---

## One thing before you start

If you have been using AI coding tools for more than a month and you feel like the results are inconsistent — like it works great some days and fails you on others — there is a reason for that, and it is not the model. It's how you're working with it.

Post 1 will name the trap.

---

*Posts 1 and 2 launch simultaneously next Tuesday. Post 1 names the trap; Post 2 introduces the fix. Start there.*

*Companion repo: [from-zero-to-ai-engineer](https://github.com/david-gracia/from-zero-to-ai-engineer)*

*Subscribe to get each post in your inbox on publish day.*
