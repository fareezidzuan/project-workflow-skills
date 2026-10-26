# Shared project conventions

This file is the single source for naming and folder rules. Any skill that writes project docs (setup, PRD/spec generators, meeting notes, design docs, handoff) should follow it, so files from different skills land in the same places with the same names. Change a rule here once and every skill follows.

House defaults (`house-defaults.md`) may override the items marked *(house default)*.

## 1. Repo docs naming (`docs/`, inside or outside the repo)
1. Folders and subfolders under `docs/` are lowercase kebab-case: `features/`, `decisions/`, `session-logs/`, `uat/`, `handoff/`, `security/`, `archive/`, `features/feature-a/`.
2. Files directly in `docs/` are ALL CAPS with hyphens: `PRD.md`, `TODO.md`, `FIGMA-MAP.md`, `OPEN-QUESTIONS.md`.
3. Files inside any folder or subfolder are lowercase kebab-case: `decisions/001-short-title.md`, `features/feature-a/sub-feature.md`.
4. `README.md` keeps its name everywhere. The `.md` extension is always lowercase.
5. Outside `docs/`, repo folders and files are kebab-case; root files `CLAUDE.md`, `README.md`, `DESIGN.md`, `LICENSE` keep their conventional names.
6. Feature specs live in `docs/features/` (one file per feature, or a folder per feature). Repos set up before v2.2 may have `docs/specs/`; record `Docs names: legacy (kept by choice)` in the repo `CLAUDE.md` to keep it.

## 2. Workspace folder set (outside git)
Core folders keep the same number in every project.

```
<project>/
├── CLAUDE.md
├── 00-dev/              the repo, only if it lives in the workspace
├── 01-meeting-notes/
├── 02-ideation/
├── 03-media/            screenshots, photos, reference images (originals)
├── 04-documents/        proposals, briefs, BRD/PRD/FRD as received, spreadsheets
├── 05-design-files/     .fig backups, .psd, .ai, .sketch, .xd; exports/ for raw exports
├── 06-… 07-… 08-…       optional slots, e.g. 06-brand-assets, 07-content
└── 09-deprecated/       always 09; each item with a short DEPRECATED.md
```

- All lowercase kebab-case.
- Per-feature inputs: `02-feature-a/` with `00-meetings/`, `01-ideation/`, `02-documents/` inside.
- Lite with raw files: only `CLAUDE.md`, `03-media/`, `09-deprecated/`.
- Existing projects may keep legacy names. Record `Workspace names: legacy (kept by choice)` in the workspace `CLAUDE.md`; the health check then stops flagging them.

## 3. Dated files
- **Meeting notes** *(house default)*: `YYMMDD-topic.md` (example `260930-label-review.md`) or `YYYYMMDD-topic.md`. One format per project.
- **Session logs:** one scheme per project, lowercase names.
  - Daily: `yyyy-mm-dd.md`, no topic in the name.
  - Monthly: `<project>-log-mm-yy.md`.
  - Another session in the same period is appended as a new `## Session N` section, never a new file.
- **Decisions:** `docs/decisions/nnn-short-title.md`, numbered in order, never renumbered. Use the folder or a single `DECISIONS.md`, not both; once a single file passes about 20 entries, split it into the folder.

## 4. Source-of-truth precedence (Figma-first projects)
Figma for layout, visuals, and final copy · spec (`docs/features/`) for behaviour, rules, and states · `docs/decisions/` overrides both until they are updated · the prototype is never the source of truth.

## 5. What belongs in `CLAUDE.md`
`CLAUDE.md` is the lobby directory, not the offices.

| Belongs | Goes elsewhere, with a one-line pointer |
|---|---|
| What the project is (2–3 lines) | Decision details → `docs/decisions/` |
| Platform, stack, run commands | Feature rules and states → `docs/features/` |
| Folder or code map | Figma links and frame status → `docs/FIGMA-MAP.md` |
| Source-of-truth precedence | Dates, tickets, blockers → `docs/PRD.md`, `docs/TODO.md`, spec headers |
| Hard rules that apply to every task | Gotchas and corrections → `docs/LESSONS.md` |
| Doc index, inputs paths, GitHub, repo location, setup version, assets line | Session history → `docs/session-logs/` |
| Workflow commands in order | |
| **Status table:** one row per module, status words only | |
| **Must-know lines:** at most 5, each one line with a link to its lesson or decision | |

Feature index lines carry links only (status lives in the status table):
`- feature-a: spec docs/features/feature-a/ · decisions 011, 015 · Figma: FIGMA-MAP § feature-a`

Size: warn above 10 KB.

## 6. Archive layout
```
docs/archive/
├── README.md                     index: what is here, when moved, why
├── todo/todo-done-yyyy-mm.md
├── open-questions/open-questions-closed-yyyy-mm.md
├── session-logs/<original name>   whole files keep their name
└── decisions/<original name>      superseded decisions keep their number
```
Whole files keep their name. Extracted content is `<source>-<what>-<yyyy-mm>.md` (month archived). Claude skips `docs/archive/` unless asked. Details in `archiving.md`.

## 7. Design assets
| Asset | Location |
|---|---|
| Source design files, raw exports | Workspace `05-design-files/` (`exports/`) |
| Brand originals (logo masters, brand guide, font files) | Workspace `06-brand-assets/` |
| Reference images, screenshots, photos | Workspace `03-media/` |
| Optimised assets the code uses | Repo: `public/` or `src/assets/` (web), `Assets.xcassets` (iOS), `res/drawable/` (Android) |
| The design itself | Figma, linked in `docs/FIGMA-MAP.md` |

Flow: design → export raw to `05-design-files/exports/` → optimise (resize, compress, WebP/SVG/WOFF2) → copy into the repo's asset folder.
