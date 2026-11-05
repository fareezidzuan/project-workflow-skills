# Feature spec template

Used by `feature-brief` at step 5. Header and naming follow `project-repo-setup/references/conventions.md` and `templates.md`. Delete sections that do not apply; a short true spec beats a complete stale one.

## Header

```markdown
Status: Draft | In review | Final
Inputs: <path relative to the inputs root> §<section>, …
```

Untraced variant (the inputs access rule was not met):

```markdown
Status: Draft · Untraced — written without: <input names> (<reason>, <yyyy-mm-dd>)
```

## Body

```markdown
# <Feature name>

## Objective
<One or two sentences: what this lets the user do.>

## User and problem
Primary user:
Problem:

## Success criteria
- <Observable outcomes, not implementation details>

## Scope
In scope:
Out of scope:

## User stories
- As a <user>, I want <action> so that <outcome>.

## User flow
1. <Happy path, step by step>

Alternative and error paths:
- <What happens when it goes wrong or the user leaves midway>

## Rules and permissions
- <Who may do what; enforced on the server, not only hidden in the UI>
- <Business rules; all-or-nothing vs partial success; duplicate actions>

## States and edge cases
- Loading, empty, success, partial, disabled, error, permission-denied
- Rapid double-click or duplicate submit
- Network or API failure
- Stale data, concurrent changes
- <Feature-specific edge cases>

## UI
Figma-first projects: link the frames from `docs/FIGMA-MAP.md`; list only behaviour that Figma cannot show (interaction rules, state triggers). Other projects: screens, component reuse (existing vs new), responsive behaviour.
Follow `DESIGN.md`; say so under "New or changed" if the feature needs a token or component it does not have.

## Copy
Figma-first: final copy lives in Figma; list only copy rules (tone, error recovery wording). Other projects: primary action, confirmation, success, error and empty-state wording.

## Data and API
Required data:
API needs:
Validation rules:

## Analytics
- <Events, if the project tracks them>

## Acceptance criteria
- [ ] <Testable statement; another person can mark it pass or fail without asking what it meant>

## Checks
Results of the feature's second-pass reviews and tests that are not recorded in `docs/uat/` (for example: second-pass-ui, second-pass-backend, test), newest first, each with date and verdict.

## Open questions
- <Undecided rule and who decides; each also in `docs/OPEN-QUESTIONS.md`>
```

## Quality bar

- Acceptance criteria are testable and cover every state under "States and edge cases", or say which are deferred.
- Nothing contradicts `DESIGN.md`, `CLAUDE.md`, or an accepted decision.
- Status is words only; no dates, tickets or blockers in the header.
- No secrets, personal data, or production URLs.
