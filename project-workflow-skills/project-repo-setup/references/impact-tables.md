# Impact tables

Show the relevant table before asking the question. Adapt wording to the project; use the user's real folder names.

## Full vs Lite (Step 1)

| | Full | Lite |
|---|---|---|
| For | Client work, team projects, apps, long-running work | Landing pages, experiments, side projects, one-offs |
| Questions | All of F1–F10 | 5: type and stack, GitHub, repo location, where Claude runs, raw files |
| Defaults | Chosen in the interview | Docs inside the repo, daily logs, solo, synced folder allowed with safety rules |
| Files | Per create-when (`profiles.md`) | `CLAUDE.md`, `README.md`, `.gitignore`, `docs/TODO.md`, `docs/decisions/`, `docs/session-logs/` (+ minimal workspace if raw files) |
| Always kept | Approval gate, safety scan, no push without a yes | Same |
| Later | — | "Upgrade to full setup" asks only the missing questions |

## Docs placement (F8)

| | Docs inside the repo | Docs outside the repo |
|---|---|---|
| Claude and `CLAUDE.md` | Read by default; short relative paths | Needs an absolute path and folder access (`additionalDirectories` in `.claude/settings.local.json`) |
| Version history | Every change committed, diffable, tied to the code change | Only the storage's own history; no link to commits |
| Team and devs | Anyone who clones gets the docs | Only people with access to that folder |
| Repo size | Small for text | Repo stays small |
| Drift docs ↔ code | Easy to keep aligned in one commit | Can fall out of sync unnoticed |
| Paths and commands | Portable | Machine-specific; breaks if the folder moves |
| Security | Anything committed stays in history forever | Easier to keep confidential client material private |
| Backup | GitHub | Depends on the cloud drive |

Guidance: interpreting docs (PRD, specs, decisions, TODO, lessons, logs, UAT) usually inside; raw inputs usually outside; confidential client material is a reason for outside; recommend **Split** when both apply.

## Repo location (F8)

| | Local, non-synced folder | Inside a synced folder (Google Drive, OneDrive, Dropbox) |
|---|---|---|
| Git safety | No sync conflicts | Sync can damage `.git` (two machines, files still downloading) |
| Backup | GitHub only | GitHub plus the cloud copy |
| Other devices | Clone on each device | Same folder on every signed-in device |
| Speed | Fast | `node_modules`, build output and `.git` keep syncing; most sync clients cannot skip subfolders |
| Claude access | Grant once per session | Same |

**Recommendation by team answer:** solo, freelance, or side job → synced folder is fine with the safety rules below. Team → local folder recommended; offer migration for existing repos. Record the choice: `Repo location: <where> (chosen: <reason>). <Drive safety rules apply.>`

**Drive safety rules (repo stays in a synced folder):**
- Mark the repo folder "Available offline" (online-only placeholder files can break git).
- Wait until the sync client shows up to date before commits, pulls, and branch switches.
- Do not have the repo open on two machines at once.
- Push to GitHub at the end of every session.

**Migration to a local folder (only on request, each step with an impact preview):**
1. Commit and push all branches (create the GitHub repo first if pending).
2. Clone to the local folder; check branches match.
3. Fix paths: relative workspace links such as `../` become one absolute path line in `CLAUDE.md`; update `additionalDirectories`.
4. Rename the old synced copy to `_moved-to-local-<yyyy-mm-dd>`; never delete it. The user removes it when happy.

## Where Claude runs and access to inputs (F9)

| Route | Works from | Impact |
|---|---|---|
| Local path | This computer, or a cloud session linked to it while it is on | Fastest; depends on the computer being on |
| Cloud-drive folder link | Any session with that drive's connector | Works from phone or web; slower; some types (`.fig`, audio) cannot be read |
| Attach files | Any session | Fine for one or two files |

Record in `CLAUDE.md`:
```
Inputs (outside the repo):
- Local:  <absolute path>
- Drive:  <folder link>   (cloud sessions read this through the drive connector)
- If neither can be opened: stop and ask before writing or changing a spec.
```
