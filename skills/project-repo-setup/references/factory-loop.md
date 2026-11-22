# Autonomous factory loop (Anti-slop P3)

Optional **outer loop** for Full / code projects that already have a clean inner loop (lint/types, guardrails, verification artifacts). Load at Step 8 only when the user asks about background fuzzing, post-release agents, or auto-merge — or when `Factory:` is already recorded and they say "run the factory loop."

**Folders only, Lite, and design-only: skip.** Never enable by default.

## Hard warning

Automating a loop that still produces slop only **accelerates slop**. Do not offer factory / auto-merge until:

1. Deterministic checks exist and pass on `main` (lint / types / tests the project already runs).
2. Soft-only rule piles are under control (anti-slop / guardrails — or the user explicitly accepts residual prose risk).
3. Verification path is understood (`verify-artifacts` / feature map / runtime verify as appropriate).

If those are missing → say so, point at P0–P2 skills, and **stop**. Do not invent CI or cloud agent billing without a yes.

## What this loop is

After a **stable release** (or tagged build the user names), an isolated coding agent may:

1. **Fuzz / explore** the build like a user (prefer `docs/FEATURE-MAP.md` IDs; fake/test data only).
2. **File** unexpected crashes or UI failures as bugs (issue or session note — project's norm).
3. **Propose fixes** on a branch / PR (one concern per PR when practical).
4. **Run** the project's verify suite (lint, tests, verify-artifacts evidence).
5. **Open a PR** for human review — or auto-merge **only** if the user previously opted in and gates are green.

Cloud agent hosts (e.g. Cursor Cloud Agents) are **examples**, not requirements. Use whatever runner the user already has and names.

## CLAUDE.md stamps

Record only after an explicit yes:

```text
Factory: off | explore-only | pr-only | auto-merge
Factory trigger: <manual | after-release-tag | after-stable-channel>
Factory runner: <none | cloud-agent | other the user named>
```

| Value | Meaning |
|---|---|
| `off` | Default. No background factory. |
| `explore-only` | Agent may explore/fuzz and report; no code PRs without a fresh yes |
| `pr-only` | Agent may open fix PRs; **never** merge |
| `auto-merge` | Rare. Merge only when gates below pass **and** user set this stamp |

Changing toward `auto-merge` requires a **second** explicit confirmation that lists the gates.

## Auto-merge gates (all required)

Only when `Factory: auto-merge`:

1. Lint / typecheck / unit+integration tests the project defines — green on the PR.
2. Production build (or the project's release build) — green.
3. `verify-artifacts` (or equivalent evidence table) — no critical gaps; Assumed/MANUAL only if the user already accepted that class of risk in writing.
4. No new secrets / production credentials used; no production data mutation.
5. Branch protection / required checks on the host still apply — do not bypass them.
6. Human can revoke: set `Factory:` back to `off` or `pr-only` at any time.

If any gate fails → leave the PR open; do not merge; report the gap.

## Delivery-loop step: `factory-run`

Optional. Run only when:

- User says "run the factory loop" / "fuzz the last release" / similar, **or**
- `Factory:` is `explore-only` | `pr-only` | `auto-merge` and they confirm this trigger.

**Never** start from Folders-only / Lite. **Never** start if prerequisites above fail.

Read: `CLAUDE.md` Factory lines, `docs/FEATURE-MAP.md`, release tag or channel the user names, existing CI, `verification.md`, guardrails status.

Do not push, merge, or spend paid cloud minutes without a yes for that run.

1. Confirm prerequisites (table: check | status | blocker?).
2. Confirm trigger artifact (tag, build id, or "local preview build").
3. Plan exploration paths from the feature map (cap scope — do not boil the ocean).
4. Execute explore/fuzz with fake data; collect failures.
5. For each actionable failure (if mode allows): branch → minimal fix → lint/tests → verify-artifacts rows → open PR (or report only in explore-only).
6. If `auto-merge` and all gates green → merge only via the host's allowed path; otherwise stop at PR.
7. Report: runs attempted, bugs found, PRs opened, merges (if any), residual risk.

## Step 8 offer (rare)

On Full / code wrap-up, **after** anti-slop + verification briefing, ask once only if the stack looks mature (CI + tests exist):

> "Optional later: a gated factory loop (fuzz after release → fix PR). Default stays off. Want it explained, or skip?"

Do not set `Factory: auto-merge` in Step 8. At most draft `Factory: off` or leave the line absent until they ask.

## Health check

- `Factory: auto-merge` but no CI / no tests / no Guardrails and soft-only LESSONS pile → **High**; recommend downgrade to `pr-only` or `off` until P0–P2 gaps close.
- `Factory: pr-only` or `auto-merge` without `FEATURE-MAP.md` on a multi-route app → **Low**; offer map draft (exploration quality).
- Missing `Factory:` line is **not** a finding (default off).

## What not to do
- Do not require a named cloud vendor or paid plan.
- Do not fuzz production or use production credentials.
- Do not auto-merge by default or "to save tokens."
- Do not run factory loops on designer / Folders-only projects.
- Do not treat factory PRs as exempt from Spec-Driven one-unit discipline when fixing product features — factory fixes stay minimal and scoped to the found failure.
