# Health check and audit checklist

Used by Step 2 (audit) and Health check mode. All checks are read-only. Skip any check whose subject is recorded as a deliberate choice in `CLAUDE.md` (legacy names, repo location, Lite with no workspace).

**Folders only (`Git: none`):** run groups A, B and D against the workspace and its `docs/`. In group C run only the secrets scan (no `.gitignore`, history or GitHub checks), and never flag "no repo" or "no GitHub" as a finding. If code has appeared in the workspace, suggest "add Git" once.

## Group A: Structure drift
- Every path named in either `CLAUDE.md` exists, in the exact case.
- Every real top-level folder (workspace and repo) appears in the folder map.
- The workspace and repo `CLAUDE.md` link to each other.
- Standard files exist for the setup level (see `profiles.md`, create-when). A missing doc that has become relevant is suggested, e.g. a Figma link with no `FIGMA-MAP.md`, a second UI language with no `GLOSSARY.md`.
- **Setup version:** `Setup: project-repo-setup vX` in `CLAUDE.md` is older than the installed skill → offer to update commands, rules and templates to the current version (show each changed file as a diff).
- **Spec-Driven gateways (Full only):** repo has Full docs (e.g. `docs/PRD.md`) and is missing root `AGENTS.md`, `docs/PROGRESS-TRACKER.md`, or `context/` → **Low**; offer to add from `templates.md` + `context-pack.md` and add `Agents:` / `Context:` / `Progress:` lines to `CLAUDE.md`. Do not flag on Lite or Folders only (`Git: none`).
- **Context pack completeness (Full only):** `context/` exists but is missing any of `README.md`, `project-overview.md`, `architecture.md`, `code-standards.md`, `ai-workflow-rules.md`, `ui-context.md`, `progress-tracker.md` → **Low**; offer to add only the missing files from `context-pack.md` without overwriting filled ones.
- **Context freshness (Full only):**
  - `context/project-overview.md` still all placeholders while `docs/PRD.md` has real goals/users → **Low**; offer to fill overview from PRD (show draft; save only after yes).
  - `docs/ARCHITECTURE.md` exists with content and `context/architecture.md` has empty Invariants (or is missing) → **Low**; offer to copy boundaries/invariants into the context file and keep the longer doc as the detail link.
  - `DESIGN.md` exists and `context/ui-context.md` still has empty Pointer / layout stubs → **Low**; offer to refresh the pointer and key constraints from `DESIGN.md` (do not copy the whole design system).
  - `context/progress-tracker.md` does not point at `docs/PROGRESS-TRACKER.md`, or the living tracker is missing while the pointer exists → **Med**; restore the pointer template and/or create the living tracker.
- **Profile F gaps:** `Profile: F` (or architecture mentions durable jobs / hybrid storage / realtime rooms / tool-calling) and any of these are missing → **Low** (offer from templates / context-pack): `docs/ARCHITECTURE.md`, Profile F sections in `context/architecture.md`, `.claude/rules/ai-app-rules.md`; **Med** if auth/realtime exists in code but `docs/security/` is missing (suggest security-docs).
- **Agent tooling (Full / code, informational):** no `Agent skills:` line and the stack names third-party SDKs → **Low**; offer the Step 8 recommendations from `agent-tooling.md` (version-matched docs / official skills). Missing `PR bot:` is not a finding — bots stay optional.
- **Anti-slop / soft-only rules (Full / code):**
  - `docs/LESSONS.md` has **5+** entries (or Must-know is full at 5) and `context/code-standards.md` has empty **Encode in tooling** / no lint config referenced, and no `Guardrails:` line beyond `none yet` → **Low**; offer promote-to-lint from `anti-slop.md` (show which LESSONS look encodable; draft only after yes). Prefer matching IDs from `guardrails-pack.md` when drafting.
  - Root `AGENTS.md` is long (**>~80 lines** or many bullet rules) while lint/type commands exist but custom bans for repeated LESSONS are absent → **Low**; offer to trim soft rules and encode the hard ones (do not delete Spec-Driven read-order).
  - `context/code-standards.md` missing Comments / Escape hatches / Encode in tooling sections on a Full repo that already has the pack → **Low**; offer to add those sections from `context-pack.md` without overwriting filled content.
  - Escape hatches / banned patterns are **filled** but `Guardrails:` is still `none yet` (or Encode in tooling has no recipe ids / draft path) while a linter or test runner exists → **Low**; offer optional scaffold from `guardrails-pack.md` (draft only after yes; no install without a second yes).
  - **Profile F:** `Profile: F` (or architecture lists realtime / durable jobs) and neither `realtime-after-membership` nor `no-long-ai-in-request` appears under Guardrails / Encode in tooling → **Low**; offer those recipe stubs from `guardrails-pack.md`.
- **Feature map (Full / code, informational):** app has multiple user-facing routes (or Profile F / runtime verify in use) and no `docs/FEATURE-MAP.md` → **Low**; offer draft from `verification.md` (placeholders only; save after yes). Do not flag Folders-only. Having `FIGMA-MAP.md` alone does not satisfy this — different purpose.
- **Progress tracker stale shape:** `docs/PROGRESS-TRACKER.md` exists but lacks Current phase / In progress / Completed sections → **Low**; offer to restore the template headings without wiping session notes.
- **Duplicated content:** a `CLAUDE.md` paragraph that repeats a decision, spec, or FIGMA-MAP entry. Fix: first merge any detail found only in `CLAUDE.md` into the target doc, then replace the paragraph with a one-line pointer.
- **Must-know lines:** more than 5 → flag for review; when over 5 on a Full/code project, also offer anti-slop promote-to-lint for any that are detectable by tooling.
- **Status table** disagrees with `docs/PRD.md` (status section) → flag.
- **Untraced specs:** any spec with `Untraced` in its header → list until re-traced.
- **Workspace names** differ from the canonical set in `conventions.md` and legacy is not recorded → offer rename (with impact preview) or "keep legacy names".
- **Lite with no workspace:** raw files (PDF, images, recordings, `.fig`) appear in the repo → offer to create the minimal workspace and move them out.

## Group B: Naming
- `docs/` rules from `conventions.md`: a file directly in `docs/` not in ALL CAPS; a file inside a folder with capitals (except `README.md`); a folder under `docs/` not lowercase kebab-case. Each is a Rename; case-only renames use the two-step method.
- Mixed naming schemes (dates vs features, kebab vs Title Case, `specs/` vs `features/`).
- **Legacy specs folder:** `docs/specs/` exists and `Docs names: legacy` is not recorded → offer a rename to `docs/features/` (two-step `git mv`, then update every reference; impact preview lists each file that mentions `docs/specs`) or "keep legacy names".
- Session logs: more than one scheme, undated files, per-feature logs → list older files and offer to move them to `docs/archive/session-logs/`.
- Meeting notes not matching the project's date format.

## Group C: Safety
- Run the safety scan in `gitignore-template.md` over every file that is not ignored, plus the history scan.
- `.gitignore` covers `.env*` (keeps `.env.example`), `.claude/settings.local.json`, `.claude/worktrees/`, build output, and the design-source safety net. It does not ignore all of `.claude/`.
- Tracked files that match ignore rules → `git rm --cached <file>` (after approval).
- Hard-coded personal absolute paths in commands, rules, or `.claude/launch.json` (the one allowed place is the inputs line in `CLAUDE.md`).
- **Repo in a synced folder:** if the choice is recorded, check only the Drive safety rules: conflict copies in `.git` (files with "(1)" or "conflicted"), unpushed commits. If not recorded, show the repo-location table.
- **GitHub backup missing:** repo in a synced folder and `GitHub Repo: pending` or no remote → **Med**; **High** if there are also unpushed commits older than 7 days. "Can't be fixed here" when the user must create an account or sign in.
- Raw files in the repo with no workspace (see group A).
- **Security docs** (only when the app has logins, a database, a backend or API, or third-party services):
  - No `docs/security/` → **Med**; suggest security-docs.
  - A document is missing sections from security-docs `references/templates.md`, or the stack has parts with no matching stack add-on rows → **Low**.
  - `security-checklist.md` has launch-blocking items not `PASS` → **High** before a release, otherwise **Med**.
  - A security document's `Updated` date is older than the last commit touching migrations or schema, auth config, or a new service in the package manifest → **Med** ("Needs update").

## Group D: Size
**Docs** (see `archiving.md` for actions):

| File | Warn | Act |
|---|---|---|
| Any `.md` in `docs/` | > 50 KB | > 100 KB |
| `CLAUDE.md` | > 10 KB | > 15 KB |

**Assets in repo asset folders:**

| Type | Warn | Act | Typical fix |
|---|---|---|---|
| Photos / raster (PNG, JPG, WebP) | > 500 KB | > 1 MB | Resize to display size, convert to WebP |
| Hero / full-width (name or folder contains `hero`, `banner`) | > 1 MB | > 2 MB | Same, plus responsive sizes |
| SVG icons / illustrations | > 50 KB | > 100 KB | Clean the SVG; remove hidden layers and embedded bitmaps |
| App icons / mobile assets | > 500 KB per file | > 1 MB | Export only the required sizes |
| Fonts | > 200 KB per file | > 500 KB | WOFF2, subset |
| Video | any video | > 5 MB | Host externally (CDN, video platform) or keep as an explicit `.gitignore` exception |

If an image's role is unclear, use the photo levels.

## Report (H3)
One table: `# | Group | Finding | Where | Fix | Risk (Low/Med/High)`, then one count line per group. If an earlier health check was logged, mark each finding **New** or **Still open**.

## Impact preview (H4), shown before approving a group
Leave out rows marked "when" that do not apply.

| Part | Shows | When |
|---|---|---|
| Changes | Each file touched: rename / move / edit / new, as `before → after` | Always |
| Preview | Before/after tree (structure, naming) or diff (`.gitignore`, `CLAUDE.md`, commands) | Always |
| Benefit | One line on what gets better | Always |
| Context cost | Tokens before → after (estimate: about 4 characters per token; labelled as an estimate), per file and per typical session | Doc sizes change |
| Blast radius | How many files reference what is changing, and which | Always |
| Risk | Low / Med / High per change, with a reason | Always |
| Who's affected | Teammates who must pull; open branches touching the same files | Team projects |
| Order | Fixes that must come first (e.g. B renames before D archive) | Groups overlap |
| Score | Findings in the group, before → expected after | Always |
| Can't be fixed here | Actions outside the repo (rotate a secret, create an account) | When they exist |
| Drive sync warning | Wait for sync before committing; check for duplicate old-case files | Repo in a synced folder |
| Side effects | Links, commands, or habits that change with it | Always |
| Verification | How it will be proved: re-run the check, resolve links, build | Always |
| Undo | `git revert <commit>` for this group's commit | Always |

Then ask: **Fix all in group / Pick items / Skip.**

## Result (after fixing a group)
What changed, what was skipped and why, links updated, verification outcome, actual score after, tokens saved, commit name (`health check: <group> – <summary>`). Each group is its own commit, made only after a yes.

## Record (H5)
Append to today's session log:
```
## Session N - Health check
- Setup version: vX (skill vY)
- Findings: A n · B n · C n · D n (New n, Still open n)
- Fixed: …
- Skipped: … (reason)
- History scanned to: <commit>
```
