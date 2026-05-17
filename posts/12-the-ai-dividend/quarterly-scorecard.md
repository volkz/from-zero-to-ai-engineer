# Quarterly AI Dividend Scorecard

A 7-row measurement template. Fill in actual numbers quarterly.
Every metric includes a disclaimer column — do not publish a metric without it.

---

## Scorecard — Q[N] YYYY

| Metric | Definition | Direction | This Quarter | Baseline | Disclaimer |
|---|---|---|---|---|---|
| **Time to first PR** | Calendar days from engineer start date to first merged PR | ↓ lower is better | [N] days | [N] days | Directional; cohort size [N]; confounded by task complexity and team support |
| **AI-PR cycle time** | Wall-clock hours from branch creation to merge for AI-assisted PRs vs. baseline | ↓ lower is better | [N] hrs vs [N] hrs | [N] hrs | Pilot-scoped; not corrected for PR size; self-reported AI-assistance flag |
| **Defect escape rate** | High/critical bugs reported in production per 100 PRs | ↓ lower is better | [N]/100 | [N]/100 | Small denominator; 90-day lag before stable count; severity classification inconsistent pre/post |
| **PR rework rate** | % of PRs requiring >2 revision rounds after initial review | ↓ lower is better | [N]% | [N]% | Directional; reviewer consistency not controlled; scope changes count as rework |
| **Re-prompt rate** | Average number of prompts per task to reach a satisfactory output | ↓ lower is better | [N] prompts | [N] prompts | Self-reported; "satisfactory" not uniformly defined |
| **Governance coverage** | % of active repos with AGENTS.md + at least 3 active skills + named owners | ↑ higher is better | [N]% | [N]% | Automated by CI lint; does not measure artifact quality, only presence |
| **False-positive rate** | % of multi-agent review findings marked false positive by human reviewers | ↓ lower is better | [N]% | [N]% | Manual tracking; under-reported (engineers may not mark FPs explicitly) |

---

## Maintenance cost line item

| Item | Estimated allocation |
|---|---|
| Governance catalog ownership | [N]% of 1 FTE (or named rotation) |
| Quarterly audit ritual | [N] hours/quarter |
| Onboarding new engineers to the loop | [N] pairing sessions/quarter |
| False-positive tuning | [N] hours/quarter |
| **Total** | [sum] |

This line item belongs in the same slide as the benefits. If it's not there, the ROI
claim is incomplete.

---

## Lead-author cover note (per quarter)

Use this paragraph as the framing for the scorecard when sharing internally or
publishing externally:

> These metrics reflect [N] engineers over [N] weeks in [Q/YYYY]. All directional
> numbers are pilot-scoped and not corrected for confounders including task complexity,
> engineer experience level, or baseline variation across teams. We report them to
> track our own trajectory, not to make universal claims. The false-positive rate for
> multi-agent review was [N]% — we consider ≤15% acceptable given the coverage depth.
> Governance maintenance cost was approximately [N]% of one engineer's time.
> Next quarter's focus: [one-sentence priority].

---

## Anti-patterns to avoid

- **Wins-only reporting.** If the only metric you publish is the one that moved in the
  right direction, you're marketing, not measuring.
- **Uncontrolled comparisons.** "AI-assisted PRs are 30% faster" is meaningless without
  controlling for PR size, engineer experience, and task complexity.
- **LOC as velocity.** Lines of code generated is not a productivity metric. It measures
  how much the agent typed, not whether it was useful.
- **Claiming the dividend before it's paid.** The dividend is paid over 6–12 months of
  compounding governance and measurement. Week-3 numbers are too early to publish.
