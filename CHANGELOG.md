# Changelog

## 1.11.0 — 2026-11-22
Anti-slop P0: high-trust / Inverse Pyramid foundation for Full + code (Folders only unchanged).

- **project-repo-setup v2.8:** new `references/anti-slop.md` (deterministic base → verification → short prose); Step 8 offers anti-slop briefing; `CLAUDE.md` can record `Guardrails:`; `context/code-standards.md` adds Comments, Escape hatches, Encode in tooling; health check flags soft-only LESSONS / long `AGENTS.md` without tooling.
- **feature-delivery-loop v1.5:** gotchas ask Promote to lint/type/test? / Keep as LESSON only? / Both?; build avoids comment-as-workaround; update-docs records promotion path.
- **README** / **starter-prompts** updated. Plugin version `1.11.0`.

## 1.10.0 — 2026-11-20
Spec-Driven P3: agent tooling layer (vendor-agnostic). Completes the Spec-Driven upgrade track (P0–P3).

- **project-repo-setup v2.7:** new `references/agent-tooling.md`; Step 8 offers version-matched docs / official Agent Skills, optional PR bot note, and runtime-verify reminder. `CLAUDE.md` can record `Agent skills:` and `PR bot:`. Health check informational finding when SDKs exist without an Agent skills line.
- **feature-delivery-loop v1.4:** optional `bot-review` step; `test` includes optional runtime verify; prefers recorded tooling over inventing APIs.
- **context-pack:** ai-workflow-rules tooling pointer.
- **README** / **starter-prompts** updated. Plugin version `1.10.0`.

## 1.9.0 — 2026-11-20
Spec-Driven P2: Profile F (full-stack AI app) — patterns only, no vendor lock-in.

- **project-repo-setup v2.6:** F1 includes Full-stack AI app → Profile F. F2 follow-ups for auth, hybrid storage, realtime, durable jobs, tool-calling. Scaffolds Profile F `context/architecture.md`, always creates `docs/ARCHITECTURE.md`, adds `.claude/rules/ai-app-rules.md`, stamps `Profile: F`. Health check flags Profile F gaps.
- **context-pack.md:** Profile F architecture template (storage, realtime auth handshake, durable execution, tool-calling, invariants).
- **security-docs v1.2:** handoff to feature-brief for auth-boundary / membership-before-realtime specs.
- **feature-brief v1.3 / feature-delivery-loop v1.3:** Profile F unit guidance; backend second-pass lens for AI-app invariants.
- **README** / **starter-prompts** updated. Plugin version `1.9.0`.

## 1.8.0 — 2026-11-20
Spec-Driven P1: Full `context/` agent memory pack (Folders only and Lite unchanged unless upgraded).

- **project-repo-setup v2.5:** Full scaffolds write `context/` (overview, architecture, code-standards, ai-workflow-rules, ui-context, progress pointer + README) from new `references/context-pack.md`. `CLAUDE.md` stamps `Context: context/`. `AGENTS.md` requires reading `context/` in order before coding. Health check covers pack completeness and freshness vs PRD / ARCHITECTURE / DESIGN / living progress tracker.
- **feature-delivery-loop v1.2:** reads `context/` before plan/build; offers to add a missing pack on Full projects.
- **feature-brief v1.2:** loads `context/project-overview.md` and `context/architecture.md` when present; non-negotiables cite context architecture invariants.
- **brand-style-profile v1.4:** when `context/` exists, refreshes `context/ui-context.md` as a short pointer to `DESIGN.md` (does not create the pack).
- **README** / **starter-prompts** updated for the context pack. Plugin version `1.8.0`.

## 1.7.0 — 2026-11-20
Spec-Driven P0 for Full setups (Folders only and Lite unchanged unless upgraded).

- **project-repo-setup v2.4:** Full scaffolds write root `AGENTS.md` and `docs/PROGRESS-TRACKER.md`, and stamp `Agents:` / `Progress:` lines plus a Spec-Driven one-unit rule in `CLAUDE.md`. Lite → Full upgrade and health check offer the missing gateways. Conventions name `AGENTS.md` and `PROGRESS-TRACKER.md`.
- **feature-brief v1.1:** spec template adds Non-negotiables, Implementation units, and Verification checklist; follow-ups can update the progress tracker and split TODO by unit.
- **feature-delivery-loop v1.1:** reads `AGENTS.md` / `PROGRESS-TRACKER.md` when present; plans from Implementation units; honours non-negotiables; updates the tracker after plan/build/test/docs (with approval).
- **README** and **starter-prompts:** Spec-Driven path documented; new prompts for planning conversations, units, and progress.
- Plugin version `1.7.0`.

## 1.6.0 — 2026-11-05
- **feature-brief v1.0 (new):** writes one feature spec in `docs/features/` with the project's spec header (Status, Inputs, Untraced), the inputs access rule, and Figma-wins-visuals precedence. Open questions and decisions go where the project keeps them.
- **feature-delivery-loop v1.0 (new):** plan, build one task, second-pass UI and backend reviews, test, PR review, update docs. Reviews report first and never edit until approved. The backend review reads `docs/security/`. In Folders-only projects it offers to add Git before building.
- Both new skills follow the shared-files and plain-language rules from 1.5.0, and get their own release ZIPs.
- **meeting-notes v1.5:** new handoff to `feature-brief`.
- **project-repo-setup:** handoff line only; version stays v2.3 so the health check doesn't flag every project's setup stamp as outdated.
- Works-with block in every skill lists all six; README, download links, `plugin.json` and marketplace description updated.

## 1.5.0 — 2026-11-03
For designers with no GitHub experience.

- **Install without Git:** README install steps for the Claude desktop and web app, Cowork, and Claude Code. Release ZIPs (one per skill, plus a plugin ZIP with all four) are built and attached to each GitHub release by `.github/workflows/release-zips.yml` (`scripts/build-skill-zips.sh`).
- **Skills work when uploaded alone:** each skill ZIP carries copies of `conventions.md` and `plain-language.md`; skills look in their own `references/` first.
- **project-repo-setup v2.3:** new **Folders only** setup (no Git or GitHub; docs in `<workspace>/docs/`), **Add Git later**, designer trigger phrases ("start a new client project", "organise my project files"), a Git-familiarity question recorded as `Explain: plain | standard`, and a fallback for apps with no folder access. The `CLAUDE.md` setup stamp now matches the skill version (was v2.1 / v2.0).
- **conventions.md:** section 0 (where project docs live, `Git:` and `Docs:` lines); decision template included so skills can log decisions without slash commands.
- **plain-language.md (new):** tone rules and a glossary of Git terms with Figma analogies, used by every skill.
- **meeting-notes v1.4, brand-style-profile v1.3, security-docs v1.1:** write to the project's `Docs:` folder, work in Folders-only projects, log decisions directly when `/log-decision` is unavailable, follow `Explain: plain`.
- **docs/starter-prompts.md (new):** things to say, grouped by task.

## 1.4.0
- brand-style-profile v1.2: codebase tokens, Figma/code reconcile, project `DESIGN.md` output.
