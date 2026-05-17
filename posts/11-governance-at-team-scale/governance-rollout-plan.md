# Governance Rollout Plan

A three-phase template for standing up AI governance at team scale.
Copy and fill in the [BRACKETS] before sharing with stakeholders.

---

## Artifact Ownership

| Artifact | Owner | Review cadence | Last reviewed |
|---|---|---|---|
| Root `AGENTS.md` | [team/person] | Quarterly | [date] |
| Per-service `AGENTS.md` | [service owner] | Quarterly | [date] |
| Rules (`.cursor/rules/`, `.claude/skills/`) | [platform/AI team] | Per-PR + quarterly | [date] |
| Skills (`.claude/skills/`) | [platform/AI team] | Per-PR + quarterly | [date] |
| Commands (`.claude/commands/`) | [team] | Per-PR | [date] |
| MCP server(s) | [infra/platform team] | Per-PR + security review | [date] |
| `CODEOWNERS` entries | [eng lead] | Per-quarter | [date] |

---

## PR Checklist — Governance Changes

Run this on every PR that touches AGENTS.md, rules, skills, commands, or MCP config.

- [ ] No secrets, tokens, or internal URLs that should not be public
- [ ] No instructions to disable security tools or skip tests
- [ ] Rule globs are as tight as possible — not `**/*` unless truly global
- [ ] Command steps do not run arbitrary network installs without version pinning
- [ ] External resources (skills.sh packages, third-party MCP) are from trusted sources
- [ ] New skills have a named owner in CODEOWNERS
- [ ] New rules have a rationale section
- [ ] Change has been smoke-tested: open a fresh session, run the activation probe

---

## Phase 1 — Foundation (Weeks 1–4)

**Goal:** Every active repo has a baseline governance pack. Engineers can use AI
assistants with consistent results on common tasks.

**Milestones:**
- [ ] Root `AGENTS.md` in every active repo (use the generator CLI or starter pack)
- [ ] `.cursorignore` reviewed — secrets, build artifacts, large fixtures excluded
- [ ] 3–5 high-value rules covering the most common mistakes (error handling, testing, forbidden deps)
- [ ] 2–3 skills for the most repeated workflows (new service, migration, code review)
- [ ] `CODEOWNERS` entries for `.cursor/rules/` and `.claude/skills/`
- [ ] Team trained on the governance PR checklist

**Success signal:** Engineers stop re-explaining the same constraints in every session.

---

## Phase 2 — Scale (Weeks 5–10)

**Goal:** Governance is self-service. Engineers can find, install, and contribute
patterns without a platform team gatekeeper.

**Milestones:**
- [ ] Internal skill registry or catalog (shared repo, internal npm package, or Hub CLI)
- [ ] Generator CLI for bootstrapping new repos: `npx @your-org/ai-resources generate`
- [ ] Lint CI on all repos: `agents-md-lint` + `markdownlint-cli2` in `.github/workflows/`
- [ ] MCP test-runner tool deployed and registered for active repos
- [ ] Multi-agent review pipeline running in advisory mode on PRs
- [ ] Quarterly review process established and calendared

**Success signal:** New engineers find and use existing governance without asking in Slack.

---

## Phase 3 — Compound (Ongoing)

**Goal:** The governance layer improves automatically as the team uses it. Learnings
from sessions become artifacts; artifacts reduce the cost of future sessions.

**Milestones:**
- [ ] Compounding habit established: every significant session ends with an AGENTS.md or
  rule or skill update if a durable learning was found
- [ ] Multi-agent review moved from advisory to blocking on critical severity
- [ ] CONTRACT envelope in CI: STATUS: FAIL blocks merge
- [ ] Quarterly AI Dividend Scorecard produced and shared (Post 12 template)
- [ ] Governance PR checklist in CI as an automated lint step

**Success signal:** The AI layer visibly improves quarter over quarter without a dedicated
platform team sprint driving each improvement.

---

## Quarterly Ritual

Every quarter, run through this in a 60-minute team session:

1. **Audit skills and rules.** Which haven't been activated in 90 days? Archive them.
2. **Activation probe every active skill.** Do the descriptions still match real task
   language, or has vocabulary drifted?
3. **False-positive review.** What percentage of multi-agent review findings were marked
   false positive? If >20% for any agent, narrow the charter.
4. **AGENTS.md review.** Do the commands still work? Has the stack changed? Are the
   forbidden patterns still correct?
5. **Contributor count.** How many engineers contributed governance changes this quarter?
   If it's fewer than three, governance is becoming someone's side project.

---

## CODEOWNERS Fragment

```
# AI governance — changes require platform/AI team review
.cursor/rules/           @your-org/platform-ai
.claude/skills/          @your-org/platform-ai
.claude/commands/        @your-org/platform-ai
AGENTS.md                @your-org/platform-ai
**/AGENTS.md             @your-org/platform-ai
.github/workflows/lint-ai-config.yml  @your-org/platform-ai
```
