# Project Workflow Skills

Six Claude skills for designers who work with Figma, code, and clients. No GitHub experience needed: see [Install](#install) and [No Git? No problem](#no-git-no-problem). Install them together: they share one set of naming and folder conventions and hand off to each other at the right moments.

| Skill | What it does | Version |
|---|---|---|
| [`project-repo-setup`](skills/project-repo-setup/) | Sets up and health-checks a project's folders and repo: Folders only (no Git), Full or Lite setup, add Git later, read-only audit, health check with impact previews (changes, risk, token savings, undo), dry runs | v2.3 |
| [`meeting-notes`](skills/meeting-notes/) | Turns Fireflies, Granola, or Read AI transcripts, pasted notes, or Figma comments into a structured note, then offers decisions, action items, and open questions as follow-ups; saves a cleaned transcript outside the repo | v1.5 |
| [`brand-style-profile`](skills/brand-style-profile/) | Analyses Figma files, codebase tokens, brand guides, websites, and images into a reusable style profile and a project `DESIGN.md`, flags Figma/code mismatches, then creates matching social posts, UI, marketing, icons, and illustrations | v1.3 |
| [`security-docs`](skills/security-docs/) | Writes five security documents (rules, auth and permissions, data protection, threat model, pre-launch checklist) in `docs/security/`, then turns one rule at a time into a tested control | v1.1 |
| [`feature-brief`](skills/feature-brief/) | Writes one feature spec in `docs/features/`: objective, scope, flow, states, rules, acceptance criteria. Opens and cites its inputs (or marks the spec Untraced), keeps Figma as the source for visuals, and files open questions and decisions where the project keeps them | v1.0 |
| [`feature-delivery-loop`](skills/feature-delivery-loop/) | Takes an approved spec through plan, build (one task at a time), second-pass UI and backend reviews, test, PR review, and a docs update. Reviews report first and never edit until you approve | v1.0 |

## Install

**New to GitHub?** You don't need an account, Git, or the terminal. Pick the Claude app you use and follow its steps. Download links work once a release has been published.

| Download | Use it for |
|---|---|
| [All six skills (plugin)](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/project-workflow-skills-plugin.zip) | Cowork, or any Claude app that installs plugins |
| [project-repo-setup](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/project-repo-setup.zip) · [meeting-notes](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/meeting-notes.zip) · [brand-style-profile](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/brand-style-profile.zip) · [security-docs](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/security-docs.zip) · [feature-brief](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/feature-brief.zip) · [feature-delivery-loop](https://github.com/fareezidzuan/project-workflow-skills/releases/latest/download/feature-delivery-loop.zip) | Claude desktop or web app: upload one skill at a time |

Each skill ZIP already includes the shared naming rules and plain-language guide, so a skill uploaded on its own still works.

### Claude desktop or web app (claude.ai)
1. Download the skill ZIPs you want from the table above. Don't unzip them.
2. In Claude, open **Settings → Capabilities**. Make sure code execution and file creation is on (skills need it).
3. Under **Skills**, choose **Upload skill** and pick one ZIP. Repeat for each skill.
4. Start a chat and say, for example, "Start a new client project for a café." Claude uses the skill automatically.

Without a connected folder, Claude gives you the files to download and tells you which folder each one goes in.

### Claude Cowork (recommended for designers)
Cowork can work directly in your project folders, so files land in the right place without any downloading.
1. Download the **All six skills (plugin)** ZIP.
2. In Cowork, open the plugins area, choose upload, and pick the ZIP.
3. When Claude asks for folder access, choose the folder where you keep client projects.

### Claude Code (terminal)
- `/plugin marketplace add fareezidzuan/project-workflow-skills`, then `/plugin install project-workflow-skills@project-workflow-skills`.
- **Updates:** in `/plugin` → **Marketplaces**, select this marketplace and choose **Enable auto-update**. Or update by hand with `/plugin marketplace update project-workflow-skills`.

Menu names in the Claude apps change from time to time. If a step doesn't match what you see, search the Claude help centre for "upload skill" or "install plugin".

### Updating (desktop, web app and Cowork)
Auto-update only exists in Claude Code. Elsewhere:
1. Check [CHANGELOG.md](CHANGELOG.md) for what's new. Each skill's version is on the line under its title in `SKILL.md`.
2. Download the new ZIP and upload it again. Remove or replace the old copy so only one version is installed.

Your projects keep working after an update; the next health check offers any new files.

## No Git? No problem
Say "start a new client project" and choose **Folders only**. You get the project folders and docs (to-dos, open questions, decisions) with no Git or GitHub. Meeting notes, brand profiles, security docs, and feature specs all work the same way. If the project later gets code, say "add Git" and your docs move into a repo without being renamed.

Setup asks once how familiar you are with Git. If you're new to it, every skill explains in plain words and skips the technical commands. See the [plain-language guide and glossary](skills/project-repo-setup/references/plain-language.md) (Git terms explained with Figma analogies), and [starter prompts](docs/starter-prompts.md) for things to say.

## Getting started: one project, start to finish

1. **Set up the project:** "Set up a new project for a café website."
   You get a workspace (`01-meeting-notes/`, `03-media/`, `05-design-files/`, `06-brand-assets/` …) and, if you choose Lite or Full, a repo with `CLAUDE.md` and docs. With Folders only, the docs sit in the workspace's `docs/` folder. At the end, it offers the next two steps.
2. **Process the kickoff meeting:** "Meeting notes from my last Fireflies call."
   The note is saved to `01-meeting-notes/260120-kickoff.md`. Decisions go to `docs/decisions/`, tasks to `docs/TODO.md`, and questions to `docs/OPEN-QUESTIONS.md` (in the repo, or in the workspace for Folders only), each only after you approve.
3. **Capture the brand:** drop the logo and brand guide in `06-brand-assets/`, then say "Build a style profile from these."
   You review the colours, type, and rules, then it is saved as a Design System and as `brand-profile.md`.
4. **Create on-brand designs:** "Make three Instagram post variants announcing our opening."
   Built from the profile, checked against it, and saved to `05-design-files/exports/`.
5. **Spec a feature:** "Write the spec for bulk lead assignment."
   `feature-brief` opens the inputs it cites, asks up to five questions, and drafts `docs/features/bulk-lead-assignment.md` with a traced header. The index line, open questions, and decisions are filed only after you approve.
6. **Build it, one step at a time:** "Plan bulk lead assignment", then "Build task 1".
   `feature-delivery-loop` plans, builds one task, runs the second-pass UI and backend reviews (findings only, no edits until you approve), tests against the acceptance criteria, reviews the branch, and updates the status table, TODO, and session log.
7. **Secure the app:** once it has logins, a database, or outside services, say "Write the security docs."
   Claude drafts an app brief from the repo, interviews you one document at a time, and saves them to `docs/security/`. Then "Turn rule R1 into code" makes and tests one control at a time.
8. **Keep it tidy:** "Health check my repo" every few weeks. It finds drift, oversized docs and images, and safety gaps, and shows the impact of each fix before changing anything.

## How they connect

```
project-repo-setup ──creates──▶ CLAUDE.md · workspace folders · docs/
        │                               ▲            ▲
        │ conventions.md                │            │
        ▼                               │            │
meeting-notes ──writes──▶ 01-meeting-notes/ · decisions · TODO · open questions
brand-style-profile ──writes──▶ 06-brand-assets/brand-profile.md · DESIGN.md · exports/
security-docs ──writes──▶ docs/security/ · TODO · open questions · decisions
feature-brief ──writes──▶ docs/features/ · index lines · open questions
feature-delivery-loop ──reads──▶ spec · DESIGN.md · docs/security/ ──updates──▶ status table · TODO · session log
```

## For maintainers
Release ZIPs are built by `.github/workflows/release-zips.yml` whenever a GitHub release is published (run `scripts/build-skill-zips.sh` to build them locally). Edit the shared `conventions.md` and `plain-language.md` only in `skills/project-repo-setup/references/`; the build copies them into each skill ZIP.

## Make it yours
In `skills/project-repo-setup/references/`, copy `house-defaults.example.md` to `house-defaults.md` and fill in your conventions (meeting-note format, where repos live, languages). Keep that file private.

## Licence
MIT — see [LICENSE](LICENSE).
