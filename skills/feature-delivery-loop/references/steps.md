# Steps

Load only the step you are running. The shared rules in `SKILL.md` apply to every step. Table columns are the output format for review steps.

Contents: plan · build · second-pass-ui · second-pass-backend · test · review-pr · update-docs

## plan
Read: `CLAUDE.md`, the spec, `DESIGN.md`, `docs/FIGMA-MAP.md` (Figma-first), `docs/PRD.md`, `docs/ARCHITECTURE.md`, relevant `docs/decisions/` and `docs/security/` entries, and the source and reusable components the feature will touch.

Do not edit source, database or configuration files. Produce:
1. Feature summary and an acceptance-criteria check: are the criteria testable and complete? Is the spec header Final, In review, Draft or Untraced?
2. Open questions, assumptions, risks.
3. Files likely to change, grouped: frontend, backend, database, tests, docs.
4. A numbered build plan in small, reviewable tasks.
5. Dependencies and migration or deployment considerations.
6. A test plan mapped to the acceptance criteria.
7. A branch name: `feature/<feature-name>`.

End with: `Plan ready for approval. No code changed.`

## build
Read: `CLAUDE.md`, the spec, `DESIGN.md`, the Figma frames in `docs/FIGMA-MAP.md` for the task's screens, the approved plan (this conversation, or the task list in `docs/TODO.md`), relevant `.claude/rules/`, and the existing components, endpoints, tests and git diff.

No approved plan, or the task is ambiguous → stop and propose the smallest sensible task before editing.

1. State the exact task and the files you expect to change.
2. Make the change. Use semantic tokens from `DESIGN.md` and existing components; include loading, empty, error, disabled and success states where they apply; validate on the client for UX and on the server for trust boundaries.
3. Run the most relevant lint, type-check, test and build commands the project has.
4. Inspect the final git diff for unrelated changes and remove them.
5. Report: what changed and why, files changed, commands run with results, remaining assumptions or follow-ups, and which second-pass step comes next.

## second-pass-ui
Read: `CLAUDE.md`, the spec, `DESIGN.md`, `docs/FIGMA-MAP.md`, the git diff and all changed frontend files. If the project has `/design-second-pass` or `/second-pass`, run it as part of this step and add the lenses below that it does not cover.

Do not edit code. Review first, then wait for approval. Lenses:
1. Design-system alignment: semantic tokens, typography, spacing, components, icons, hierarchy. Compare against the Figma frame when a Figma connection is available; otherwise say it was not compared.
2. States: loading, skeleton, empty, error, success, disabled, permission-denied, offline.
3. Interaction safety: rapid clicks, duplicate submit, stale data, cancellation, retry, back navigation.
4. Forms: labels, validation timing, inline errors, required fields, server-error mapping, preserved input.
5. Responsive behaviour: mobile, tablet, desktop, overflow, long text, touch targets.
6. Accessibility: semantic HTML, labels, keyboard flow, focus visibility, dialog focus, contrast.
7. Scope discipline: unrelated changes, duplicated components, avoidable complexity, missing tests.
8. Copy: clarity, action labels, error recovery, status feedback, against the spec's copy rules or Figma.

Output a table: Severity (Critical / High / Medium / Low), Finding, Evidence (file and location), User impact, Source to fix (spec, Figma, prototype or build), Recommended fix, Test to add or verify. Then: missing acceptance criteria or ambiguous UX decisions; a verdict (`Ready for human QA`, `Needs fixes`, `Blocked by decision`); a numbered fix plan with no code changes. Record the verdict and date under the spec's Checks section after the user says yes.

## second-pass-backend
Run when the feature touches API, database, auth or server logic.

Read: `CLAUDE.md`, the spec, `docs/ARCHITECTURE.md`, `docs/decisions/`, the five documents in `docs/security/` when they exist (`security-rules.md`, `auth.md`, `data-security.md`, `threat-model.md`, `security-checklist.md`), the git diff, changed backend files, migrations and tests. No security documents → say so and offer "Write the security docs? (security-docs)".

Do not edit code. Lenses:
1. Authentication and server-side authorisation for every sensitive action, checked against `auth.md` and the spec's rules.
2. Input validation, type checks, allowlists, pagination and limits, safe error responses.
3. Data exposure: least-privilege fields, user or tenant scoping, personal data in logs, response shape, checked against `data-security.md`.
4. Business rules: duplicate actions, idempotency, race conditions, partial failure, transaction boundaries.
5. Database: migration safety, constraints, indexes, foreign keys, nullability, rollback impact, query efficiency.
6. API quality: status codes, error contract, backwards compatibility, abuse and rate concerns.
7. Secrets and configuration: environment variables, nothing in source or logs, safe defaults.
8. Reliability: timeouts, retries, observability, useful logs without personal data, test coverage.
9. Controls: which rules in `security-rules.md` this change implements, weakens or leaves untested.

Output a table: Severity, Finding, Evidence, Risk, Recommended fix, Test to add or verify. Then: required product decisions; migration and deployment cautions; a verdict (`Ready for human QA`, `Needs fixes`, `Blocked by decision`); a numbered fix plan with no code changes. Never print secret values; mask them (`sk-••••3f2a`) and tell the user to rotate anything exposed.

## test
Read: `CLAUDE.md`, the spec, `docs/uat/` if it exists, the git diff, test configuration and relevant tests.

Do not change product code. Run only safe local checks.
1. Extract the acceptance criteria and the edge cases from the spec.
2. Map each to an automated test, a command, or a manual QA scenario.
3. Run the relevant lint, type-check, unit and integration tests and the production build.
4. Review the changed areas for regressions and missing coverage.
5. Confirm second-pass findings are fixed or explicitly deferred.

A test that cannot run → say exactly why and what is needed. Output a table: criterion or scenario, method, result (`PASS`, `FAIL`, `BLOCKED`, `MANUAL`), evidence, source to fix for each failure (spec, Figma, prototype or build). Then: commands run and a result summary; a remaining manual checklist; a status (`Ready to merge`, `Fix required`, `Blocked`). Save results to `docs/uat/` when the project has formal test rounds (one round file, issues listing the source to fix); otherwise add a dated line under the spec's Checks section. Do this only after the user says yes.

## review-pr
Read: `CLAUDE.md`, the spec, `docs/ARCHITECTURE.md`, `DESIGN.md`, relevant rules and decisions, git status, the diff against the base branch, changed files and tests.

Do not change code, commit, merge or push. Review the diff, not only the final files, and flag scope creep even when it looks correct. Lenses: acceptance-criteria alignment; design-system and UI quality; code quality, duplication and conventions; API, database, security, validation, permissions and error handling; tests, build, migrations, docs and deploy risk; regression risk and backwards compatibility.

Output findings ranked Critical / High / Medium / Low with location, impact and fix. Then: what is strong and should stay; required before merge; follow-ups that are not blockers; a verdict (`Approve`, `Approve with follow-ups`, `Request changes`, `Blocked`).

## update-docs
The user may give a mode: `session` (end of a working session), `qa` (after test), or `released` (after merge or release).

Read: `CLAUDE.md`, the spec, `docs/PRD.md`, `docs/TODO.md`, `docs/session-logs/`, `docs/OPEN-QUESTIONS.md`, `docs/LESSONS.md`, `docs/uat/` if it exists, the git diff and this conversation. Read `ARCHITECTURE`, `FIGMA-MAP` or `security/` only when the feature changed those areas.

Update documentation only. Record confirmed facts from the diff, test results and decisions. Do not mark work complete while tests or human QA are pending. Show every change and save only after the user says yes.

| What happened | Where it goes |
|---|---|
| Working session ended | The project's `/log-session`; without it, today's file in `docs/session-logs/` following the project's scheme, appending a `## Session N` section rather than a new file |
| A choice was made | The project's `/log-decision` (`docs/decisions/nnn-short-title.md`, numbered, never renumbered) |
| Module status changed | The `CLAUDE.md` status table row (status words only) and the status section of `docs/PRD.md`, together; the health check flags them when they disagree |
| Tasks done or new | `docs/TODO.md`, under the feature |
| Open question raised or answered | `docs/OPEN-QUESTIONS.md` |
| A gotcha or correction | One line in `docs/LESSONS.md`; only the most important becomes a must-know line in `CLAUDE.md` (at most five) |
| Test results | `docs/uat/`, or the spec's Checks section |
| Spec behaviour changed | The spec itself, and the header status if it moved |
| Architecture, Figma map or security facts changed | The matching document, confirmed changes only |

Keep entries short, dated, and useful to a future session with no memory of this one. `CLAUDE.md` stays a directory, not a copy of other docs, and under about 10 KB. Report the files updated, what remains open, and the next step.
