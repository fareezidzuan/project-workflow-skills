# Spec-Driven context pack

Used by Full setups only (not Lite, not Folders only). Load at scaffold Step 6 and when a health check offers to add the pack. Placeholders only — never invent product facts.

Write these under `<repo>/context/` (kebab-case). Keep `docs/PRD.md`, `docs/features/`, `DESIGN.md`, and `docs/PROGRESS-TRACKER.md` as the human/product sources; context files are the short agent-facing memory layer.

## Create order
1. `README.md`
2. `project-overview.md`
3. `architecture.md`
4. `code-standards.md`
5. `ai-workflow-rules.md`
6. `ui-context.md`
7. `progress-tracker.md` (pointer to the living tracker)

Also ensure `docs/PROGRESS-TRACKER.md` and root `AGENTS.md` exist (P0). Stamp `Context: context/` in the repo `CLAUDE.md`.

---

## `context/README.md`
```markdown
# Context pack

Spec-Driven long-term memory for coding agents. Read in this order before changing code:

1. `project-overview.md` — what we are building
2. `architecture.md` — system shape and invariants
3. `code-standards.md` — how code is written here
4. `ai-workflow-rules.md` — how the agent must behave
5. `ui-context.md` — visual / UI rules (see also `DESIGN.md`)
6. `progress-tracker.md` — points at the living tracker

Living progress is updated in `docs/PROGRESS-TRACKER.md` every unit. Feature specs live in `docs/features/`. Do not duplicate long product docs here — link out.
```

## `context/project-overview.md`
```markdown
# Project overview

> Agent summary. Product map and feature index: `docs/PRD.md`.

## Summary
<One paragraph: what this product is.>

## Goals
- <Measurable goal>

## Audience
- <Primary users>

## Core flows
1. <Happy-path flow name>

## Stack
- <Framework / language / hosting — match CLAUDE.md>

## Out of scope (MVP)
- <Explicit non-goals>

## Success criteria
- <Observable outcomes>
```

## `context/architecture.md`
```markdown
# Architecture

> Agent blueprint and invariants. Longer wiring notes (when present): `docs/ARCHITECTURE.md`.

## System shape
- <Apps / packages / services and their roles>

## Boundaries
- <What talks to what; trust boundaries>

## Storage
- <What lives where: database vs files vs blob vs cache>

## Folder map
- <Key repo folders the agent should know>

## Invariants (never violate)
1. <Rule that must always hold>
2. <Rule that must always hold>

## Swap / evolution notes
- <How a seam or provider could change later>
```

## `context/code-standards.md`
```markdown
# Code standards

> Project conventions for generated and reviewed code. Prefer existing patterns in the repo over inventing new ones.

## Language and types
- <TypeScript / Swift / Kotlin / … rules>

## Framework
- <App Router, routing, server vs client, etc.>

## Style and structure
- <Formatting, naming, file layout, components vs utilities>

## Errors and validation
- <Client UX validation vs server trust boundaries; error shape>

## Testing
- <What must have tests; commands to run>

## Do not
- <Patterns to avoid>
```

## `context/ai-workflow-rules.md`
```markdown
# AI workflow rules

> Behavioural guardrails for coding agents. Product facts still come from specs and decisions.

## Scope
- Work on exactly one implementation unit at a time (see the active feature spec and `docs/PROGRESS-TRACKER.md`).
- Do not expand into unrelated cleanups; file them in `docs/TODO.md`.

## Ambiguity
- If a prompt is vague, crosses a non-negotiable, or needs an architecture choice, stop and ask. Do not invent product or architecture decisions.

## Sources of truth
- Spec (`docs/features/`) wins behaviour; Figma / `DESIGN.md` wins visuals when Figma-first; accepted `docs/decisions/` override both until updated.
- Honour `context/architecture.md` invariants.

## Evidence
- Report commands run and results. Separate verified facts from assumptions.

## Progress
- After every completed unit, update `docs/PROGRESS-TRACKER.md` (phase, in progress, completed, session notes) with the user's approval.

## Safety
- No secrets in code or docs. No production credentials or production data changes while testing. No commit, push, or merge unless the user asks.
```

## `context/ui-context.md`
```markdown
# UI context

> Agent-facing visual rules. Canonical design tokens and component rules: `DESIGN.md` (written/updated by brand-style-profile). Figma links: `docs/FIGMA-MAP.md` when present.

## Pointer
- Design system: `DESIGN.md`
- Brand originals: workspace `06-brand-assets/` (outside git)

## Layout constraints
- <Breakpoints, density, max width — or "see DESIGN.md">

## Component rules
- <Reuse existing components; when new ones are allowed>

## Accessibility
- <Labels, focus, contrast expectations>

## Do not
- <Visual patterns to avoid>
```

## `context/progress-tracker.md`
```markdown
# Progress tracker (pointer)

The living Spec-Driven progress file is:

**`docs/PROGRESS-TRACKER.md`**

Read and update that file every unit. Keep this pointer so the `context/` pack stays complete; do not maintain a second copy of phase/unit state here.
```
