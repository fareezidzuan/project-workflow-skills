# Templates

Replace `<…>` placeholders. Never invent product facts.

## Workspace `CLAUDE.md`
```markdown
# <Project> — Workspace

<One or two lines: what the project is and for whom.>

Repo: `<path to repo>` (code map in its CLAUDE.md).
Setup: project-repo-setup v2.3
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

Setup: project-repo-setup v2.3 (folders only)
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

Setup: project-repo-setup v2.3
Git: yes · Docs: `docs/` · Explain: <plain | standard>
GitHub Repo: <url | pending> · default branch <main>
Repo location: <path> (chosen: <reason>). <Drive safety rules apply.>
Workspace: <path>  (see its CLAUDE.md)
Inputs (outside the repo):
- Local: <path>
- Drive: <folder link>
- If neither can be opened: stop and ask before writing or changing a spec.
Assets: originals in <workspace>/05-design-files/, optimised in <repo asset folder>
Raw files: <yes | no>   <!-- Lite only -->

## Platform and stack
## Run
## Code map
## Source of truth
## Rules
- Skip `docs/archive/` unless asked.
## Must-know (max 5, one line + link each)
## Status
| Module | Design | Dev |
|---|---|---|
## Features
- <feature>: spec `docs/features/<feature>.md` · decisions <nnn> · Figma: FIGMA-MAP § <feature>
## Docs
| File | Purpose |
|---|---|
## Commands
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
