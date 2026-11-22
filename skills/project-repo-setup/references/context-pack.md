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

## Profile F — extend `context/architecture.md`

When the project uses **Profile F** (full-stack AI app), use this body instead of the short architecture template above (or merge any already-filled sections). Keep vendor names only if the user chose them. Mirror the same headings into `docs/ARCHITECTURE.md` with more detail if needed.

```markdown
# Architecture

> Agent blueprint and invariants. Detail: `docs/ARCHITECTURE.md`.

## System shape
- App: <framework / router>
- Auth: <none | managed IdP | custom>
- Data: <ORM / DB>
- Realtime: <none | presence | shared state>
- Background jobs: <none | durable worker>
- In-product AI: <none | tool-calling agent>

## Boundaries
- Public routes: <list>
- Protected routes / APIs: <list>
- Trust: browser is untrusted; enforce authz on the server

## Storage
- **Metadata DB:** users, projects, roles, status enums, blob URLs — <DB>
- **Object / blob (if hybrid):** large JSON, generated specs, exports — <store>; DB holds URLs only
- **Cache / other:** <none | …>

## Realtime (if any)
- Room or channel model: <how rooms map to projects>
- Auth handshake: issue tokens only after session auth **and** membership check
- What syncs: <presence | document/canvas state | both>

## Durable execution (if any)
- Trigger: API enqueues job and returns <run id>
- Worker: runs long AI / multi-step work outside the request lifecycle
- Client: subscribes to status / streaming updates
- Do not run >~30–60s model work inside a typical serverless request handler

## Tool-calling agent (if any)
- Tools (examples): <addNode | updateRecord | …> — each validated
- Prefer iterative tools over one giant structured output when schemas are large
- Side effects go through tools; humans see progress via realtime or job status

## Folder map
- <app routes, lib/domain, db, storage adapter, jobs>

## Invariants (never violate)
1. Sensitive actions and realtime tokens require server-side auth and authorization (e.g. project membership).
2. Hybrid storage: do not stuff large or hot-rewritten artifacts into oversized DB columns when blob storage was chosen.
3. Long-running AI runs in a durable job; the HTTP handler stays fast.
4. In-product agents mutate state only through explicit, validated tools.
5. No secret values in source, specs, context files, or logs.

## Swap / evolution notes
- Auth, blob, realtime, and job providers should sit behind thin adapters so one can change without rewriting the app.
```

## `context/code-standards.md`
```markdown
# Code standards

> Project conventions for generated and reviewed code. Prefer existing patterns in the repo over inventing new ones.
> Soft "Do not" lines are a last resort — encode recurring bans in lint/type/test (see Encode in tooling).

## Language and types
- <TypeScript / Swift / Kotlin / … rules>

## Framework
- <App Router, routing, server vs client, etc.>

## Style and structure
- <Formatting, naming, file layout, components vs utilities>

## Comments (product code)
- Prefer self-explaining names and structure over long comments.
- Do **not** write comments that justify a workaround, timer hack, or architecture bypass — fix the root cause or ask.
- Brief *why* comments are OK for non-obvious invariants that tooling cannot express yet.
- Does not apply to meeting notes, Figma comments, or non-code docs.

## Errors and validation
- <Client UX validation vs server trust boundaries; error shape>

## Testing
- <What must have tests; commands to run>

## Escape hatches / banned patterns
- <e.g. no raw useEffect in product UI — use framework helpers; list only what this project bans>
- <e.g. no setTimeout / rAF as a substitute for fixing a sync boundary>
- <e.g. no cross-imports between <server> and <client> / <main> and <renderer> directories>

## Encode in tooling
- Lint / formatter: <none | eslint | biome | …> · config path: <path>
- Custom rules or bans: <none yet | rule ids>
- Typecheck / compile gate: <command>
- When a LESSON or review correction repeats, promote it here and into the linter — do not only append `AGENTS.md`.

## Do not
- <Patterns to avoid that are not yet encoded above>
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

## Tooling (optional)
- Prefer version-matched framework/SDK docs or vendor Agent Skills the project recorded in `CLAUDE.md` over inventing APIs.
- Optional PR review bots and runtime verify are part of the delivery loop when configured — see project-repo-setup `agent-tooling.md`. Do not install tools without the user's yes.

## Anti-slop
- Prefer deterministic checks (lint, types, tests) over growing soft rules in this file or `AGENTS.md`.
- When a correction is worth never repeating, offer to promote it to lint/type/test (project-repo-setup `anti-slop.md`) instead of only writing `docs/LESSONS.md`.
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
