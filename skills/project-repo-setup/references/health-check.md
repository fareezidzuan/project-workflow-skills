# Health check and audit checklist

Used by Step 2 (audit) and Health check mode. All checks are read-only. Skip any check whose subject is recorded as a deliberate choice in `CLAUDE.md` (legacy names, repo location, Lite with no workspace).

## Group A: Structure drift
- Every path named in either `CLAUDE.md` exists, in the exact case.
- Every real top-level folder (workspace and repo) appears in the folder map.
- The workspace and repo `CLAUDE.md` link to each other.
- Standard files exist for the setup level (see `profiles.md`, create-when). A missing doc that has become relevant is suggested, e.g. a Figma link with no `FIGMA-MAP.md`, a second UI language with no `GLOSSARY.md`.
- **Setup version:** `Setup: project-repo-setup vX` in `CLAUDE.md` is older than the installed skill → offer to update commands, rules and templates to the current version (show each changed file as a diff).
- **Duplicated content:** a `CLAUDE.md` paragraph that repeats a decision, spec, or FIGMA-MAP entry. Fix: first merge any detail found only in `CLAUDE.md` into the target doc, then replace the paragraph with a one-line pointer.
- **Must-know lines:** more than 5 → flag for review.
- **Status table** disagrees with `docs/PRD.md` (status section) → flag.
- **Untraced specs:** any spec with `Untraced` in its header → list until re-traced.
- **Workspace names** differ from the canonical set in `conventions.md` and legacy is not recorded → offer rename (with impact preview) or "keep legacy names".
- **Lite with no workspace:** raw files (PDF, images, recordings, `.fig`) appear in the repo → offer to create the minimal workspace and move them out.

## Group B: Naming
- `docs/` rules from `conventions.md`: a file directly in `docs/` not in ALL CAPS; a file inside a folder with capitals (except `README.md`); a folder under `docs/` not lowercase kebab-case. Each is a Rename; case-only renames use the two-step method.
- Mixed naming schemes (dates vs features, kebab vs Title Case, `specs/` vs `features/`).
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
