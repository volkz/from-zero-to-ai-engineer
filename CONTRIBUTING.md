# Contributing

## What's welcome

- **Typo fixes** — always welcome, no discussion needed.
- **Broken examples** — if a code snippet doesn't run or an AGENTS.md snippet is malformed, open a PR with the fix and paste the actual output proving it works.
- **Tool version updates** — each `posts/NN-slug/README.md` has a "last verified" line. If you've confirmed examples still work on a newer version, update it.
- **Parity examples** — if a post shows only Cursor syntax, a Claude Code equivalent (or vice versa) is a useful addition.

## What's not the right venue here

- **Thesis-altering changes** — this series reflects the author's engineering experience and opinions. If you disagree with an approach, open a Discussion; don't send a PR that reverses a design decision.
- **New posts** — contact the author directly or open a Discussion with a full outline.
- **Vendor-specific content** — every example must generalize. PRs that only work with one tool (and don't include a parity alternative) will be declined.

## Vendor-neutrality requirement

All code and prose must remain vendor-neutral. If you add a Cursor example, add the Claude Code equivalent. If you add a Claude Code example, note what the Cursor analogue would be. The `docs/tool-matrix.md` is the canonical parity reference.

## PR checklist

- [ ] `markdownlint-cli2` passes on changed files
- [ ] `agents-md-lint` passes if any AGENTS.md files changed
- [ ] "Last verified" date updated in the relevant `posts/NN-slug/README.md`
- [ ] Vendor-neutral (no single-tool-only examples without a parity note)
- [ ] No internal URLs, company names, or proprietary content
