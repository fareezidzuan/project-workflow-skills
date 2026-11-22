# Verification-first (Anti-slop P2)

Load for **Full / code** projects at Step 8 (after anti-slop / guardrails), when planning or testing a feature, or when the user asks about feature maps, verification artifacts, or runtime proof. **Folders only and design-only: skip** unless they ask.

Pairs with `anti-slop.md` (middle pyramid layer) and `agent-tooling.md` (runtime verify). **Patterns only — no required vendors** (no Bombadil / TLA+ / Lean mandate).

## Why

At high agent velocity, humans cannot review every line. Review **verification artifacts** that prove intent and invariants: command output, runtime checks against a feature map, recordings/screenshots, traces, and (when the project opts in) property or formal results.

## Feature map vs Figma map

| Doc | Answers | Not for |
|---|---|---|
| `docs/FIGMA-MAP.md` | Where is the **visual** design (file / page / frame)? | Runtime routes or how to drive the app |
| `docs/FEATURE-MAP.md` | What can a **user** do in the running app (capability IDs, entry paths, how to open)? | Layout polish or brand tokens |

Coding agents use the feature map to avoid guessing ("fix the sidebar") — they target a stable **capability id** and path.

### When to create `docs/FEATURE-MAP.md`

Offer on Full / code when: the app has multiple user-facing flows, Profile F, or runtime verify is in use. Create-when only after a yes (empty starters are a health-check smell). Not for Folders-only brand work.

### Template (`docs/FEATURE-MAP.md`)

```markdown
# Feature map

> User-facing capabilities for agents and runtime verify. Visuals: `docs/FIGMA-MAP.md`. Behaviour: `docs/features/`.

| ID | Capability | Entry (route / screen / command) | How to open (dev) | Notes |
|---|---|---|---|---|
| `auth.sign-in` | Sign in | `/sign-in` | Open URL with test user | Fake credentials only |
| `app.home` | Home / dashboard | `/` | After sign-in | |
| `<area>.<action>` | <One user job> | <path> | <steps> | |

## Out of map
- Admin-only or unfinished flows: <list or "none">

## Runtime tools (optional)
- Dev server: `<command>`
- Browser / CDP / framework MCP: `<what the project already has | none>`
```

Keep IDs stable (`kebab` or `dot` segments). Link a feature spec's Verification checklist rows to IDs when useful (`runtime:auth.sign-in`).

## Artifact types

| Type | Examples | When |
|---|---|---|
| **Command** | lint, typecheck, unit/integration, build logs | Every unit that can run them |
| **Runtime** | Route load, auth redirect, UI state, job status against a feature-map ID | When a safe local/dev server (or project browser tool) exists |
| **Visual / recording** | Screenshot, short screen recording, before/after | UI-visible units; attach path under `docs/uat/` or artifacts the project uses |
| **Trace** | Request log excerpt, job run id + status, websocket membership deny | API / jobs / realtime |
| **Property** (opt-in) | Randomized UI/input sequences the project already runs | Only if configured — do not invent a stack |
| **Formal / model** (opt-in) | TLA+ / model-check notes, proof assistant results the project owns | Complex state machines — link the artifact; do not require adopting a prover |

## Delivery-loop step: `verify-artifacts`

Run **after** `test` (and after `bot-review` if used), **before** `review-pr` when the user wants an artifact-first merge gate — or fold into `review-pr` if they prefer one step. Prefer a named `verify-artifacts` step so evidence is explicit.

**Do not edit product code.** Produce a table:

| Artifact | Type | Feature-map ID (if any) | Result | Path / evidence | Verified vs Assumed |
|---|---|---|---|---|---|
| … | command / runtime / visual / trace / property / formal | `id` or — | PASS / FAIL / BLOCKED / SKIPPED | … | Verified / Assumed |

Rules:
1. Every acceptance criterion or Verification checklist row for the current units maps to at least one artifact, or an explicit SKIPPED + why.
2. Runtime rows cite a feature-map ID when `FEATURE-MAP.md` exists; otherwise say the map is missing and offer to create it.
3. Never use production credentials or production data.
4. Verdict: `Artifacts ready for human review` / `Gaps remain` / `Blocked`.
5. `review-pr` should not say **Approve** while critical artifact gaps remain, unless the user explicitly accepts Assumed/MANUAL risk.

## Runtime verify (deepened)

Same rules as `agent-tooling.md` §3, plus:
1. Prefer navigating via **feature-map IDs** and Entry paths.
2. Mark each check `Verified in runtime` vs `Assumed`.
3. If CDP / browser / framework MCP exists, use it; do not add a new toolchain without a yes.
4. Record results under the spec Checks section or `docs/uat/` per project norms.

## Advanced classes (mention only)

If the user asks for stronger assurance on a complex flow, **describe** property-based UI testing, formal model checking, or visual statecharts as optional classes and point at whatever the project already uses. Do not install Bombadil, TLA+, Lean, or similar unless they already chose that stack and say yes.

## Step 8 / health check

- Offer to create `docs/FEATURE-MAP.md` from known routes (draft from `CLAUDE.md` Code map / app router — placeholders for unknown IDs).
- Health check: Full app with multiple routes and no `FEATURE-MAP.md` while runtime verify or Profile F is in play → **Low**; offer draft.
- Do not flag Folders-only or design-only projects.

## What not to do
- Do not replace Spec-Driven specs or Figma as sources of truth — feature map is navigation/proof aid only.
- Do not require recordings or formal proofs for every PR.
- Do not enable autonomous factory / auto-merge (P3).
- Do not invent product capabilities; leave unknown rows as placeholders or open questions.
