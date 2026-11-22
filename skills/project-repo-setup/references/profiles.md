# Project profiles

Starting points for the Step 4 table. Adjust to the answers; drop what does not apply. Naming follows `conventions.md`.

Folders-only setups don't use these profiles: they get the workspace folder set plus `docs/` (see the SKILL's Folders-only setup). On "add Git", pick the profile here as usual.

## Create-when (all profiles)

| File / folder | Created when |
|---|---|
| `CLAUDE.md`, `README.md`, `.gitignore`, `docs/TODO.md`, `docs/decisions/`, `docs/session-logs/` (+ `README.md`) | Always |
| `docs/PRD.md`, `docs/OPEN-QUESTIONS.md`, `docs/LESSONS.md` | Always in Full; Lite adds them on upgrade |
| `AGENTS.md`, `docs/PROGRESS-TRACKER.md`, `context/` (six-file pack + README) | Always in Full (Spec-Driven gateway, living progress, agent memory pack); Lite and Folders only skip unless the user asks; added on Lite → Full upgrade. Templates: `templates.md` + `context-pack.md` |
| `docs/FIGMA-MAP.md`, `DESIGN.md` | A Figma file exists or the source of truth is Figma |
| `docs/GLOSSARY.md`, `docs/CONTENT-RULES.md` | Second UI language, or a domain with special terms |
| `docs/handoff/` | Someone else builds from your design |
| `docs/uat/` | Formal test rounds |
| `docs/ARCHITECTURE.md` | Backend, monorepo, more than one app, or **Profile F** (full-stack AI) |
| `docs/security/` | Logins, a database, a backend or API, third-party services, or **Profile F** (written by security-docs; Profile F always offers it at wrap-up) |
| `.claude/rules/ai-app-rules.md` | **Profile F** only (durable jobs, hybrid storage, auth-before-realtime, tool-calling limits) |
| `docs/SITEMAP.md`, `docs/SEO.md` | Website profile |
| `docs/features/` | Full setup, or the first spec is written |
| `docs/archive/` | First archive move |
| `.claude/commands/`, `.claude/rules/` | Always (at least `/log-session`, `/log-decision`, inputs access rule) |

Files that do not apply are listed in the Step 4 table as "Not created" with the reason.

## Shared repo docs

| File | Description |
|---|---|
| `PRD.md` | Short product map: goals, users, scope, non-goals, phases, status section, feature index linking to specs |
| `TODO.md` | Active tasks grouped by feature or area |
| `PROGRESS-TRACKER.md` | Living Spec-Driven handoff: current phase, active feature/unit, blockers, short session notes. Agents read and update this every unit; detail stays in `session-logs/` |
| `LESSONS.md` | Corrections and gotchas so they are not repeated (Full/code: offer promote to lint/type/test) |
| `OPEN-QUESTIONS.md` | Numbered open questions, owner, status |
| `decisions/` | One file per decision: context, options, decision, approver, date, related frame. Overrides spec and Figma until they are updated |
| `features/` | One spec per feature, or a folder with `README.md` + sub-feature files. Each spec header lists its inputs (and `Untraced` if written without them) |
| `uat/` | Round files and checklist; each issue records which source needs fixing (spec, Figma, prototype, build) |
| `session-logs/` | One scheme; sessions appended |

Root gateway (Full): `AGENTS.md` — mandatory read order for non-Claude agents; mirrors the Spec-Driven pointers in `CLAUDE.md` without duplicating long docs.

## Context pack (`context/`, Full only)

| File | Role |
|---|---|
| `README.md` | Read order for the pack |
| `project-overview.md` | Goals, audience, flows, out of scope; links `docs/PRD.md` |
| `architecture.md` | Boundaries, storage, invariants; links `docs/ARCHITECTURE.md` when present |
| `code-standards.md` | Language, framework, testing, comments/escape hatches, encode-in-tooling / guardrails recipe ids |
| `ai-workflow-rules.md` | One-unit scope, push back on ambiguity, evidence, safety, anti-slop promote path |
| `ui-context.md` | Agent UI rules; points at `DESIGN.md` |
| `progress-tracker.md` | Pointer to living `docs/PROGRESS-TRACKER.md` |

## Profile A: Figma-first app (design hub)
Figma is the shared source of truth across teams and clients; a prototype only communicates a signed-off design to developers.

| Path | Description |
|---|---|
| `DESIGN.md` | Tokens (colour, type, spacing, radius), component rules, Figma file key and variable collection names |
| `<app>/` | Prototype source (e.g. SwiftUI with XcodeGen; gitignore the generated project if regenerated) |
| `docs/FIGMA-MAP.md` | Feature → Figma file/page/frame link + status: exploring / in review / signed off |
| `docs/GLOSSARY.md`, `docs/CONTENT-RULES.md` | When create-when applies |
| `docs/handoff/` | Per-feature pack for developers, including platform differences |
| `.claude/rules/prototype-rules.md` | Figma wins visuals, spec wins behaviour, mock data only, never invent screens |

Commands (pipeline order): `/brief-feature` → `/design-second-pass` → design in Figma → `/prototype-screen` (optional, for design review) → mark frames signed off → `/sync-design-system` → `/parity-check` → `/handoff`; plus `/log-decision`, `/log-session`.

## Profile B: Mock-first web app (monorepo)
Mock data first, behind a repository seam, so the backend can change later.

| Path | Description |
|---|---|
| `apps/<name>/` | One app per audience (e.g. user, admin, public) with pages, components, stores, composables, middleware, repositories, utils |
| `packages/types/` | Canonical data model |
| `packages/mocks/` | Shared mock data and generators |
| `packages/db/` | Backend stub or local stack |
| `docs/ARCHITECTURE.md` | Wiring, data flow, repository seam, backend swap path |
| `docs/DESIGN.md` | Code-driven design system |
| `.env.example` | Variable names only |

Rules for `CLAUDE.md`: all data access through `repositories/`; types change in `packages/types` only; confirm dark mode before marking UI complete; branch flow (e.g. dev → preview → live demo).
Commands: `/second-pass` (review the diff against the seam, roles, formatting, dark mode, empty/error states), `/log-decision`, `/log-session`.

## Profile C: Web dashboard (responsive)
Start from B, then: state the layout rule (desktop-first, then responsive) and breakpoints; `docs/DESIGN.md` with table, filter, form patterns and empty/loading/error states; add a responsive check to `/second-pass` (phone width, no horizontal scroll, touch targets).

## Profile D: Native mobile app (iOS and/or Android)
Start from A, then: `ios/` and/or `android/`, each with a short `CLAUDE.md` (build, run, conventions); `docs/handoff/` includes an iOS vs Android behaviour table (back navigation, sheets, biometrics, permissions); `docs/api/contract.md` or a link once a backend exists.

## Profile E: Website (marketing or public)
`src/` (or framework equivalent), `public/`, `content/` (copy as markdown), `docs/`. Extra docs: `SITEMAP.md`, `SEO.md`, `CONTENT-RULES.md`. Only optimised assets go in `public/`; originals stay in the workspace.

## Profile F: Full-stack AI app (Spec-Driven)
Web (or monorepo) apps built with coding agents under the Spec-Driven pack, usually with auth, a database, and at least one of: hybrid storage, realtime collaboration, durable background AI jobs, or an in-product tool-calling agent.

**Use when** F1 is Full-stack AI app, or F2 answers show long-running AI, realtime rooms, or large artifacts that should not live in the primary database. Always Full (not Lite). Always create `context/`, `docs/ARCHITECTURE.md`, and offer `docs/security/`.

Name vendors only as examples the user already chose — never require a specific auth, blob, realtime, or job product.

| Path | Description |
|---|---|
| `context/` | Required; fill architecture with Profile F sections from `context-pack.md` |
| `docs/ARCHITECTURE.md` | Hybrid storage, durable execution, realtime auth, tool-calling shape, invariants |
| `DESIGN.md`, `context/ui-context.md` | UI rules for the agent |
| `app/` or `apps/<name>/` | Routes / UI (framework as answered in F2) |
| `lib/` or `packages/` | Domain, DB client, storage adapters, job clients — keep seams swappable |
| `.env.example` | Variable **names** only (auth, DB, blob, realtime, job runner, model provider) |
| `.claude/rules/ai-app-rules.md` | From `templates.md`: request handlers stay fast; membership before realtime; no secrets in docs |

**F2 follow-ups (Profile F only, after stack):** ask one at a time, record answers in `CLAUDE.md` and seed `context/architecture.md` / `docs/ARCHITECTURE.md`:
1. **Auth:** none yet / managed IdP / custom — public vs protected routes
2. **Storage:** single database / **hybrid** (metadata in DB, large artifacts in object/blob storage with URLs in DB)
3. **Realtime:** none / presence only / shared document or canvas state — who may join a room?
4. **Long-running AI (> ~30–60s):** none / **durable background jobs** (enqueue from API, worker runs, client subscribes to status) — never block the HTTP request
5. **In-product agent:** none / **tool-calling** that mutates domain state (prefer small tools over one giant structured blob)

**Default invariants** (adapt, then write into architecture Invariants):
1. Sensitive actions and realtime room tokens require server-side auth **and** membership/authorization checks.
2. Large or frequently rewritten artifacts (canvas JSON, generated markdown, exports) are not stored as huge DB rows when hybrid storage was chosen.
3. Work that can exceed the request timeout runs in a durable job; the API returns a run id / status handle.
4. In-product agents change state through explicit tools with validation — not by writing arbitrary JSON into storage.
5. Secret values never appear in source, specs, or context files.

Rules for `CLAUDE.md`: Spec-Driven one-unit builds; read `context/` before coding; link security docs once written.
Commands: `/log-decision`, `/log-session`, plus `/second-pass` when the UI stack matches Profile B/C.
**Handoffs at wrap-up:** "Write the security docs? (security-docs)", then "Fill context/architecture from your F2 answers", then optional guardrails recipes `realtime-after-membership` / `no-long-ai-in-request` (`guardrails-pack.md`), then first feature via feature-brief.

## Audit patterns seen in real projects (anonymised)
- Workspace `CLAUDE.md` folder map naming `01-ideation` and `03-documents` while the real folders were `02-ideation` and `04-documents`.
- Session logs mixing monthly files, an undated file, and per-feature logs.
- `specs/` vs `features/` not settled.
- Case mismatches under `docs/` (`docs/prd.md`, `docs/decisions/001-FEE-NOTE.md`, `docs/Some-Plan.md`).
- `.gitignore` ignoring all of `.claude/`, so new rules were never shared.
- `.gitignore` missing `.env*` and `.claude/worktrees/`.
- `CLAUDE.md` repeating decision details that also live in `docs/decisions/`.
- Working docs over 100 KB (TODO, monthly logs, PRD), loaded every session.
- Specs drafted in a cloud session that could not reach the inputs folder.
- Repos in a synced drive with no GitHub remote, so the drive was the only backup.
- Empty starter files (a FIGMA-MAP for a project with no Figma file).
- Local env backups and demo credentials sitting in app folders.
