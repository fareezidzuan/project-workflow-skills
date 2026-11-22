# Deterministic guardrails pack (Anti-slop P1)

Optional **recipes** for Full / code projects. Load with `anti-slop.md` at Step 8, when promoting a LESSON to lint, or when the user asks for agent guardrails / custom lint stubs. **Folders only and design-only: skip** unless they ask.

**Never install packages, enable plugins, or overwrite an existing lint config without an explicit yes.** Prefer extending the toolchain the repo already has.

## Goal

Turn soft bans in `context/code-standards.md` into failing checks with **helpful messages** that point at the root fix (Inverse Pyramid base layer).

## Offer flow (Step 8 or health check)

1. Detect what exists: `eslint` / `biome` / `oxlint` / SwiftLint / ktlint / `tsc` / test runner — from `package.json`, configs, or `CLAUDE.md` Platform and stack.
2. Ask once: **Scaffold agent-guardrails recipes?** → Yes (draft files) / Adapt to our linter / Skip.
3. If Yes: show a short table of recipe IDs below that match the stack (and Profile F if `Profile: F`). User picks which to draft.
4. Write drafts under a project path they approve (default suggestion: `tools/agent-guardrails/` or next to the existing lint config). Update `context/code-standards.md` **Encode in tooling** and `Guardrails:` in `CLAUDE.md` only after they accept the drafts.
5. If no linter exists: offer to **document** the bans in Encode in tooling + a `docs/TODO.md` item to add a linter later — do not invent a full toolchain.

## Directory boundaries (name the lattice)

Before drafting import rules, fill Folder map edges in `context/architecture.md` (or ask):

| Zone | Typical paths (examples only) | Must not import |
|---|---|---|
| Server / trusted | `app/api/`, `server/`, `lib/server/` | Browser-only modules |
| Client / UI | `app/(ui)/`, `components/`, `electron/renderer/` | Main-process, secrets, DB clients |
| Main / native (desktop) | `electron/main/` | Renderer React trees |
| Shared safe | `lib/shared/`, `types/` | Side effects, env secrets |

Record the project's real folders — do not invent Electron layout for a web app.

## Recipe catalog (patterns — adapt to the project's linter)

Each recipe: **ID**, intent, where it applies, and a **draft stub** the agent customizes. Messages must tell the agent what to do instead of the ban.

### `no-product-useeffect`
- **Intent:** ban raw `useEffect` in product UI; allow only under framework/helper paths the user names (e.g. `lib/effects/`, design-system internals).
- **Detect:** ESLint `no-restricted-imports` / Biome `noRestrictedImports` targeting `react` import of `useEffect` outside allowlist globs; or a small custom rule.
- **Message idea:** `useEffect is banned in product code. Use <allowed helper> or move this into <framework API path>.`

### `no-timer-escape`
- **Intent:** ban `setTimeout` / `setInterval` / `requestAnimationFrame` / `requestIdleCallback` as architecture glue in app code (allow test helpers / explicit allowlist).
- **Detect:** `no-restricted-globals` + `no-restricted-syntax`, or Biome nursery/restricted globals — scoped to `app/` / `components/`.
- **Message idea:** `Timers are not an architecture fix. Resolve the sync/boundary issue or use the project's approved scheduling helper.`

### `no-cross-boundary-imports`
- **Intent:** forbid imports across the zones in the Folder map table (server↔client, main↔renderer).
- **Detect:** `eslint-plugin-import` / `no-restricted-paths`, Nx/tag boundaries, Biome/custom resolver, or TypeScript project references — match what the repo already uses.
- **Message idea:** `Cross-boundary import: <from> must not import <to>. Move shared types to <shared path> or call through an API.`

### `no-workaround-comment-markers` (optional, light)
- **Intent:** discourage comment slop markers agents copy (`// HACK`, `// workaround justified`, `eslint-disable` without ticket).
- **Detect:** `no-warning-comments` (or equivalent) with a short allowlist; do **not** ban all comments.
- **Message idea:** `Do not justify a workaround in a comment — fix the root cause or open a LESSON and promote a real rule.`

### Profile F — `realtime-after-membership` (test stub)
- **Intent:** realtime room/channel tokens only after session auth **and** membership (or equivalent) check.
- **Detect:** unit/integration test near the token issuer; optional lint if a single helper must be used (`no-restricted-imports` on raw SDK token APIs outside `lib/realtime/`).
- **Draft:** a failing-or-skipped test skeleton that calls the issuer without membership and expects deny — fill with the project's test runner.

### Profile F — `no-long-ai-in-request` (test / review stub)
- **Intent:** long AI work (>~30–60s) must enqueue a durable job; HTTP handlers stay fast.
- **Detect:** hard to lint perfectly — prefer a test or architectural check that route handlers under `app/api/` do not call the raw model client; model client allowed from `jobs/` / `workers/` only (`no-restricted-imports`).
- **Message idea:** `Do not run long model work in the request handler. Enqueue a durable job and return a run id.`

## Minimal ESLint flat-config sketch (only if the repo already uses ESLint)

Show as a **draft** the user can paste — paths and package names must match their repo. Do not run `npm install`.

```javascript
// tools/agent-guardrails/eslint.agent-guardrails.example.mjs
// Draft only — merge into the project's ESLint config after approval.
export const agentGuardrailsExample = {
  // Example: restrict useEffect outside allowlisted folders (customize globs).
  rules: {
    "no-restricted-imports": ["error", {
      paths: [{
        name: "react",
        importNames: ["useEffect"],
        message: "useEffect is banned in product code. Use the project effect helper or an allowed framework path.",
      }],
    }],
  },
};
```

Prefer the project's existing config style (flat vs legacy). For Biome / SwiftLint / others: translate the same IDs into that tool's restrict-import / exclude-path syntax — do not force ESLint onto a Biome repo.

## After scaffolding

1. List files drafted and which recipe IDs.
2. Propose `Guardrails: <ids or path>` on `CLAUDE.md` and Encode in tooling lines.
3. Remind: CI / local lint must actually load the rules or they are still prose.
4. Point promote-to-lint (delivery loop) at these recipe IDs when a new LESSON matches.

## What not to do
- Do not require a named commercial linter or Electron.
- Do not enable auto-merge or factory fuzz loops (P3).
- Do not apply to Folders-only / brand-only projects.
- Do not delete Spec-Driven gateways — hard rules live in tooling; gateways stay short.
