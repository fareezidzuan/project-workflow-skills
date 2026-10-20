# Project Workflow Skills

Three Claude skills for designers who work with Figma, code, and clients. They share one set of naming and folder conventions, so files from each skill land in the same places.

| Skill | What it does | Version |
|---|---|---|
| [`project-repo-setup`](project-repo-setup/) | Sets up and health-checks a project's repo and workspace: Full or Lite setup, read-only audit, health check with impact previews (changes, risk, token savings, undo), dry runs | v2.0 |
| [`meeting-notes`](meeting-notes/) | Turns Fireflies, Granola, or Read AI transcripts, pasted notes, or Figma comments into a structured note, then offers decisions, action items, and open questions as follow-ups | v1.0 |
| [`brand-style-profile`](brand-style-profile/) | Analyses Figma files, brand guides, websites, and images into a reusable style profile, then creates matching social posts, UI, marketing, icons, and illustrations | v1.0 |

## Install
1. Download this repo (**Code → Download ZIP**) and unzip it.
2. Add each skill folder you want (for example `project-repo-setup/`) as a skill in your Claude app. In Claude Code, copy the folder into `~/.claude/skills/` or your project's `.claude/skills/`.

## Make it yours
In `project-repo-setup/references/`, copy `house-defaults.example.md` to `house-defaults.md` and fill in your conventions (meeting-note format, where repos live, languages). Keep that file private.

## Try it
- "Set up a new project for a marketing website."
- "Health check my repo." · "Dry run: audit this repo."
- "Meeting notes from my last Fireflies call."
- "Build a style profile from this Figma file." · "Make three Instagram variants of this post in our style."

## How they connect
- `project-repo-setup/references/conventions.md` is the shared source for naming and folders.
- `meeting-notes` saves to the workspace's `01-meeting-notes/` and feeds decisions, TODOs, and open questions into the repo docs.
- `brand-style-profile` keeps brand originals in `06-brand-assets/` and exports in `05-design-files/exports/`.

## Licence
MIT — see [LICENSE](LICENSE).
