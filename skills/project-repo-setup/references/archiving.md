# Doc size and archiving

Large docs cost context (roughly 4 characters per token: a 200 KB file is about 50k tokens), get read only partly, and keep finished items looking current. Under 50 KB is comfortable; 50–100 KB warn; over 100 KB act.

## Actions by file type (at the act level, after approval)

| File | Moves to the archive | Stays |
|---|---|---|
| `TODO.md` | Completed tasks | Open tasks |
| `OPEN-QUESTIONS.md` | Answered or closed questions, numbers kept | Open questions |
| Session logs | Whole files older than 3 months | The last 3 months |
| Session log for the current period over 100 KB | Nothing; switch the project to the daily scheme | — |
| `DECISIONS.md` | Not archived: split into `decisions/nnn-*.md`; only superseded decisions move to `archive/decisions/` | Active decisions |
| `PRD.md` | Not archived: split into a short product map plus `specs/` per feature; old versions stay in git history | The map |
| `LESSONS.md` | Not archived: condensed and grouped by topic | Everything, tidied |
| `CLAUDE.md` (> 10 KB) | Detail moves to the right doc per the scope rule in `conventions.md`; a one-line pointer stays | Pointers and rules |

## Naming in the archive
- Layout mirrors the source (see `conventions.md` §6).
- A whole file that moves keeps its name.
- Extracted content: `<source>-<what>-<yyyy-mm>.md`, dated by the month archived (`todo-done-2026-10.md`).

## Moving (never deleting)
1. Show the plan in the impact preview: what moves, roughly how many lines, the new file name, tokens before → after.
2. On approval, cut the content and paste it into the archive file under a header:
   ```
   > Moved from `docs/TODO.md` on 2026-10-18. Items completed up to that date.
   ```
3. Leave one line in the source: `Older items: docs/archive/todo/todo-done-2026-10.md`.
4. Update every link in `CLAUDE.md`, commands, rules, and specs that pointed at moved content.
5. Update `docs/archive/README.md` (what, when, why).
6. Commit on its own.
7. Make sure `CLAUDE.md` contains: "Skip `docs/archive/` unless asked."

## Splitting `DECISIONS.md` into a folder
1. One file per entry: `decisions/nnn-short-title.md`, keeping the existing number (ADR 012 → `012-…`).
2. `decisions/README.md` lists every decision with status (Proposed / Accepted / Superseded by nnn).
3. Replace references like "ADR 012" with the file path, or keep the number and add the index link once.
4. Update `/log-decision` to write a new file instead of appending.
