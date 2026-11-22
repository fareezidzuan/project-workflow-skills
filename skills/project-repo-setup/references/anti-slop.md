# Anti-slop / high-trust codebases (P0+)

Load for **Full / code** projects at Step 8 wrap-up, when a health check finds soft-only rules, or when the user asks about agent slop, lint vs AGENTS.md, or high-trust agent environments. **Folders only and design-only: skip** unless they ask.

**P1 scaffolds:** when the user wants concrete lint/test stubs, also load `guardrails-pack.md` (optional recipes — never auto-install).
**P2 verification:** feature maps and artifact-first review live in `verification.md`.

Source framing: *Coding at the Speed of Thought* / Inverse Pyramid of Agent Trust — patterns only; no required vendors.

## Inverse Pyramid of Agent Trust

Invest effort from the **base up**. Soft prose is last resort.

| Layer | What it is | Examples |
|---|---|---|
| **Base — Deterministic** | Hard constraints agents cannot talk their way past | Strict APIs, refactors that remove bad options, types, compilers, custom lint rules |
| **Middle — Verification** | Proof the agent matched intent and invariants | Tests, runtime checks, feature maps, recordings, formal checks when the project uses them |
| **Top — Prose** | Judgment calls that still need a human | Short `AGENTS.md` / `CLAUDE.md` / `context/` rules, skills, LESSONS that are not yet encodable |

**Rule of thumb:** when you correct an agent, prefer promoting the fix into the **base** (lint/type/test) over adding another line to `AGENTS.md` or Must-know. Growing soft guidance without guardrails does not scale.

## Codebase as a garden

Agents treat the repo as training data. A workaround, deprecated pattern, or long comment *justifying* a hack becomes the next agent's "house style" and spreads. Keep the lattice clean: remove weeds (anti-patterns) and encode the pruning as checks, not essays.

## Escape hatches to strip (encode, don't only document)

Agents often paper over architecture with:

- Imperative timers (`setTimeout`, `requestAnimationFrame`, `requestIdleCallback`) instead of fixing the boundary
- High-friction APIs that need deep human nuance (e.g. raw `useEffect` in product UI) when the project can ban them outside framework helpers
- **Comment slop:** long inline comments that rationalize why a bad patch was necessary — later agents copy the pattern

Prefer **self-explaining code + failing lint/type errors with a helpful message** that points at the root fix. Do **not** ban comments in meeting notes, Figma comments, or non-code docs. Product code: avoid comments that excuse workarounds; allow brief *why* for non-obvious invariants when a lint rule cannot express them yet.

## Correction → deterministic check (required ask)

Whenever a gotcha is recorded (delivery-loop `update-docs`, second-pass follow-up, or health check), ask once:

1. **Promote to lint / type / test rule?** (preferred when the mistake is detectable)
2. **Keep as LESSON only?** (judgment / product nuance)
3. **Both?** (lint now + one LESSON line for humans)

If they pick promote or both: draft the smallest rule or test stub the project's existing toolchain supports (ESLint/Biome/SwiftLint/etc.), preferring a matching recipe ID from `guardrails-pack.md` when one fits. Show the diff; **install or enable nothing** without an explicit yes. Record accepted tooling under Platform and stack or a short `Guardrails:` line in `CLAUDE.md` if useful.

If nothing can encode it yet → keep the LESSON and note "encode later" in `docs/TODO.md`.

## What not to do
- Do not delete Spec-Driven gateways (`AGENTS.md`, `context/`, progress tracker) — keep them short and point hard rules at tooling.
- Do not require Electron, TLA+, Lean, or any named linter product.
- Do not enable auto-merge or autonomous factory loops here (later, gated phases).
- Do not apply anti-slop pressure to Folders-only / brand-only projects.
