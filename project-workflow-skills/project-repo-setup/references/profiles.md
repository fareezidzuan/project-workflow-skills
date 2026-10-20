# Project profiles

Starting points for the Step 4 table. Adjust to the answers; drop what does not apply. Naming follows `conventions.md`.

## Create-when (all profiles)

| File / folder | Created when |
|---|---|
| `CLAUDE.md`, `README.md`, `.gitignore`, `docs/TODO.md`, `docs/decisions/`, `docs/session-logs/` (+ `README.md`) | Always |
| `docs/PRD.md`, `docs/OPEN-QUESTIONS.md`, `docs/LESSONS.md` | Always in Full; Lite adds them on upgrade |
| `docs/FIGMA-MAP.md`, `DESIGN.md` | A Figma file exists or the source of truth is Figma |
| `docs/GLOSSARY.md`, `docs/CONTENT-RULES.md` | Second UI language, or a domain with special terms |
| `docs/handoff/` | Someone else builds from your design |
| `docs/uat/` | Formal test rounds |
| `docs/ARCHITECTURE.md` | Backend, monorepo, or more than one app |
| `docs/SITEMAP.md`, `docs/SEO.md` | Website profile |
| `docs/specs/` | Full setup, or the first spec is written |
| `docs/archive/` | First archive move |
| `.claude/commands/`, `.claude/rules/` | Always (at least `/log-session`, `/log-decision`, inputs access rule) |

Files that do not apply are listed in the Step 4 table as "Not created" with the reason.

## Shared repo docs

| File | Description |
|---|---|
| `PRD.md` | Short product map: goals, users, scope, non-goals, phases, status section, feature index linking to specs |
| `TODO.md` | Active tasks grouped by feature or area |
| `LESSONS.md` | Corrections and gotchas so they are not repeated |
| `OPEN-QUESTIONS.md` | Numbered open questions, owner, status |
| `decisions/` | One file per decision: context, options, decision, approver, date, related frame. Overrides spec and Figma until they are updated |
| `specs/` | One file per feature, or a folder with `README.md` + sub-feature files. Each spec header lists its inputs (and `Untraced` if written without them) |
| `uat/` | Round files and checklist; each issue records which source needs fixing (spec, Figma, prototype, build) |
| `session-logs/` | One scheme; sessions appended |

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
