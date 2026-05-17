# AGENTS.md PR Review Checklist

*From 0 to AI Engineer — Post 03 artifact*

Use this checklist on every PR that creates or modifies an AGENTS.md file (or nested override).
Also use it for quarterly maintenance reviews.

---

## Before opening the PR

- [ ] **Commands are copy-pasteable.** Run each command from the repo root. Confirm it works.
- [ ] **No secrets.** No API keys, database URLs, internal system names, or proprietary tool names that shouldn't be public.
- [ ] **No invented paths.** Every folder reference in the Structure section exists. Verify with `ls`.
- [ ] **Package manager is explicit.** Exactly one package manager named. The Forbidden section bans all others.

## During review

- [ ] **Forbidden list covers non-obvious rules.** Rules that are obvious from reading the code don't need to be here. Rules that have caused incidents or review comments three or more times do.
- [ ] **Runtime expectations are stated.** The "done" definition — non-zero exit code on failure, paste actual output — is present.
- [ ] **No over-broad governance in the wrong place.** AGENTS.md is for repo-wide truth. If a rule only applies to `*.proto` files, it belongs in a `.mdc` rule (Post 04), not here.
- [ ] **Folder overrides are minimal.** Nested AGENTS.md files only state what *differs* from the parent. They don't re-copy global rules.

## Smoke test (required before merge)

- [ ] Open the client (Cursor or Claude Code) in this repo.
- [ ] Prompt: `What are the exact commands to run tests in this project?`
- [ ] Confirm the response matches what's in AGENTS.md — exact commands, correct package manager, correct flags.
- [ ] If the response is a guess ("probably npm test?"), the file hasn't loaded — investigate before merging.

## CODEOWNERS

- [ ] `AGENTS.md` and any nested `**/AGENTS.md` are covered by a CODEOWNERS entry requiring senior review.

## Quarterly maintenance review

- [ ] Commands still work after recent dependency or Node version changes.
- [ ] Structure section reflects the current folder layout (not the one from 6 months ago).
- [ ] Forbidden list includes any new rules that have been enforced only through code comments or review feedback.
- [ ] "Last reviewed" date updated.
- [ ] Any rules that have never caught a violation: consider removing or moving to documentation.

---

*10 items. If any are unchecked, the PR is not ready.*
