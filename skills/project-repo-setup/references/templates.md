# Templates

Replace `<…>` placeholders. Never invent product facts.

## Workspace `CLAUDE.md`
```markdown
# <Project> — Workspace

<One or two lines: what the project is and for whom.>

Repo: `<path to repo>` (code map in its CLAUDE.md).
Setup: project-repo-setup v2.9
Git: yes
Docs: `<repo>/docs/`   <!-- or the docs path when outside or split -->
Explain: <plain | standard>
Workspace names: canonical   <!-- or: legacy (kept by choice) -->

## Folder map (outside git)
- `01-meeting-notes/` — notes and transcripts, `<date format>-topic.md`
- `02-ideation/` — …
- `03-media/` — screenshots, photos, reference images
- `04-documents/` — briefs, proposals, requirements as received
- `05-design-files/` — source design files; `exports/` for raw exports
- `09-deprecated/` — retired work, each with DEPRECATED.md

## Rules
- Raw inputs live here, never in the repo. Specs cite them relative to this folder, e.g. `Inputs: 04-documents/brief-v1.pdf §2`.
- No credentials in this folder tree.
```

## Workspace `CLAUDE.md` — Folders only (no Git)
```markdown
# <Project> — Workspace

<One or two lines: what the project is and for whom.>

Setup: project-repo-setup v2.9 (folders only)
Git: none   <!-- say "add Git" to set up version history later -->
Docs: `docs/`   <!-- TODO, open questions, decisions; DESIGN.md sits at this folder's root -->
Explain: <plain | standard>
Figma: <link | none yet>
Workspace names: canonical

## Folder map
- `docs/` — project docs: `TODO.md`, `OPEN-QUESTIONS.md`, `decisions/`, `FIGMA-MAP.md`
- `01-meeting-notes/` — notes and transcripts, `<date format>-topic.md`
- `02-ideation/` — sketches, moodboards, early ideas
- `03-media/` — screenshots, photos, reference images
- `04-documents/` — briefs, proposals, requirements as received
- `05-design-files/` — source design files; `exports/` for finished exports
- `06-brand-assets/` — logos, brand guide, fonts; `brand-profile.md`
- `09-deprecated/` — retired work, each with DEPRECATED.md

## Rules
- Decisions are files in `docs/decisions/` (template below), written directly; there are no slash commands in this setup.
- No passwords, keys or other credentials anywhere in this folder.
```

## Repo `CLAUDE.md`
```markdown
# <Project>

<2–3 lines: what it is.>

Setup: project-repo-setup v2.9
Git: yes · Docs: `docs/` · Explain: <plain | standard>
GitHub Repo: <url | pending> · default branch <main>
Repo location: <path> (chosen: <reason>). <Drive safety rules apply.>
Workspace: <path>  (see its CLAUDE.md)
Agents: `AGENTS.md` (gateway for Cursor / Codex / Copilot; same rules)   <!-- Full only; omit on Lite -->
Context: `context/`   <!-- Full only; omit on Lite -->
Progress: `docs/PROGRESS-TRACKER.md`   <!-- Full only; omit on Lite -->
Profile: <A–F>   <!-- e.g. F full-stack AI -->
Agent skills: <none yet | names the user approved>   <!-- Full / code; from agent-tooling.md -->
PR bot: <none | configured>   <!-- optional -->
Guardrails: <none yet | recipe ids or path from guardrails-pack.md>   <!-- Full / code; anti-slop + P1 -->
Inputs (outside the repo):
- Local: <path>
- Drive: <folder link>
- If neither can be opened: stop and ask before writing or changing a spec.
Assets: originals in <workspace>/05-design-files/, optimised in <repo asset folder>
Raw files: <yes | no>   <!-- Lite only -->

## Platform and stack
<!-- Profile F: also note auth, storage mode, realtime, durable jobs, in-product agent -->
## Run
## Code map
## Source of truth
## Rules
- Skip `docs/archive/` unless asked.
- Spec-Driven: read `context/` before coding; plan before build; one implementation unit at a time; update `docs/PROGRESS-TRACKER.md` after every unit (Full).
- Prefer version-matched framework/SDK docs (or approved Agent skills) over training-data guesses; leave framework-managed `AGENTS.md` regions intact.
- Anti-slop: prefer lint/type/test constraints over growing soft rules; keep `AGENTS.md` / Must-know short. Promote recurring corrections (see `docs/LESSONS.md`) into tooling when possible; optional recipes in project-repo-setup `guardrails-pack.md`.
<!-- Profile F: honour context/architecture.md invariants (authz, hybrid storage, durable jobs, tool-calling). -->
## Must-know (max 5, one line + link each)
## Status
| Module | Design | Dev |
|---|---|---|
## Features
- <feature>: spec `docs/features/<feature>.md` · decisions <nnn> · Figma: FIGMA-MAP § <feature>
## Docs
| File | Purpose |
|---|---|
| `PROGRESS-TRACKER.md` | Current phase, active unit, blockers (Full) |
| `../context/` | Spec-Driven agent memory pack (Full) |
| `ARCHITECTURE.md` | System wiring (Profile F and backends) |
## Commands
```

## `.claude/rules/ai-app-rules.md` (Profile F only)
```markdown
# AI app rules

- Read `context/` and `docs/PROGRESS-TRACKER.md` before coding.
- Enforce auth and authorization on the server; never trust the client for membership or roles.
- Realtime: issue room/channel tokens only after auth **and** a membership (or equivalent) check.
- Hybrid storage: keep large or hot-rewritten artifacts out of oversized DB columns when blob/object storage was chosen.
- Long-running AI (>~30–60s): enqueue a durable job; do not block the HTTP request handler.
- In-product agents: mutate state through explicit validated tools, not arbitrary JSON dumps.
- Never write secret values into source, specs, context files, or logs. Use `.env.example` for names only.
- When Guardrails are enabled, encode membership-before-realtime and no-long-AI-in-request as lint/test recipes (`realtime-after-membership`, `no-long-ai-in-request`) — do not leave them as prose only.
```

## Repo `AGENTS.md` (Full setups only)
Gateway for coding agents that read `AGENTS.md` (Cursor, Codex, Copilot, Next.js managed blocks). Keep it short; point at living docs instead of copying them. When Next.js or another tool owns a marked section, leave that section alone and keep these project directives outside it. Context file bodies live in `references/context-pack.md`.
```markdown
# Agent directives

Before implementing any feature or modifying code:
1. Read `CLAUDE.md` (project lobby: stack, status, doc index).
2. Read all files in `context/` in order: `project-overview.md`, `architecture.md`, `code-standards.md`, `ai-workflow-rules.md`, `ui-context.md`, `progress-tracker.md`.
3. Read `docs/PROGRESS-TRACKER.md` (living progress) and continue from the current phase / unit.
4. Read the active feature spec under `docs/features/` (and `DESIGN.md`, `docs/ARCHITECTURE.md`, `docs/security/` when they exist and the task touches them).
5. Follow accepted decisions in `docs/decisions/` over conflicting spec or Figma notes. Honour `context/architecture.md` invariants.
6. Work one scoped implementation unit at a time. If the request is ambiguous or crosses a non-negotiable, stop and ask — do not invent product or architecture decisions.
7. After each completed unit, update `docs/PROGRESS-TRACKER.md` (phase, in-progress, completed, session notes).
8. Prefer deterministic project checks (lint, types, tests) over adding soft rules. Do not use long code comments to justify workarounds; fix the root cause or ask.

Do not commit, push, merge, or change production systems unless the user explicitly asks.
```

## `docs/PROGRESS-TRACKER.md` (Full setups only)
Living Spec-Driven handoff. Coding agents read this first every session and update it after every unit. Keep it short; put narrative detail in `docs/session-logs/`.
```markdown
# Progress tracker

## Current phase
- Phase: idle   <!-- planning | building | reviewing | testing | released | idle -->
- Active feature: none
- Spec: none
- Branch: main

## In progress
- [ ] none

## Completed (this feature)
<!-- Move ticks here as units finish; clear or archive when the feature ships -->

## Blockers and decisions needed
- none

## Session notes
<!-- Newest first: `- YYYY-MM-DD: one line` -->
```

## `docs/session-logs/README.md` (daily scheme)
```markdown
# Session logs

Name files `YYYY-MM-DD.md`. No topic in the file name.
One file per day. Another session on the same day is appended as a new section.

## Session N - <short topic>
- Done: what changed (files, frames, decisions)
- Decisions: links to `docs/decisions/` entries
- Open: questions and next steps
```
Monthly scheme: replace the first two lines with "Name files `<project>-log-MM-YY.md`" and "One file per month."

## Decision file (`docs/decisions/nnn-short-title.md`)
```markdown
# nnn — <Title>
Status: Proposed | Accepted | Superseded by nnn
Date: <yyyy-mm-dd> · Approver: <name/role>
Context:
Options:
Decision:
Related: <spec / frame link>
```

## Spec header
```markdown
Status: Draft | In review | Final
Inputs: <path relative to the inputs root> §<section>, …
```
Untraced variant:
```markdown
Status: Draft · Untraced — written without: <input names> (<reason>, <yyyy-mm-dd>)
```

## Archive header
```markdown
> Moved from `<source path>` on <yyyy-mm-dd>. <What was moved and the cut-off.>
```

## `docs/archive/README.md`
```markdown
# Archive

Claude skips this folder unless asked.

| File | Moved from | Date | Why |
|---|---|---|---|
```
