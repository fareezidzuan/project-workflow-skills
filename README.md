# Project Workflow Skills

Six Claude skills for designers who work with Figma, code, and clients. Install them together: they share one set of naming and folder conventions and hand off to each other at the right moments.

| Skill | What it does | Version |
|---|---|---|
| [`project-repo-setup`](skills/project-repo-setup/) | Sets up and health-checks a project's repo and workspace: Full or Lite setup, read-only audit, health check with impact previews (changes, risk, token savings, undo), dry runs | v2.2 |
| [`meeting-notes`](skills/meeting-notes/) | Turns Fireflies, Granola, or Read AI transcripts, pasted notes, or Figma comments into a structured note, then offers decisions, action items, and open questions as follow-ups; saves a cleaned transcript outside the repo | v1.4 |
| [`brand-style-profile`](skills/brand-style-profile/) | Analyses Figma files, codebase tokens, brand guides, websites, and images into a reusable style profile and a project `DESIGN.md`, flags Figma/code mismatches, then creates matching social posts, UI, marketing, icons, and illustrations | v1.2 |
| [`security-docs`](skills/security-docs/) | Writes five security documents (rules, auth and permissions, data protection, threat model, pre-launch checklist) in `docs/security/`, then turns one rule at a time into a tested control | v1.0 |
| [`feature-brief`](skills/feature-brief/) | Writes one feature spec in `docs/features/`: objective, scope, flow, states, rules, acceptance criteria. Opens and cites its inputs (or marks the spec Untraced), keeps Figma as the source for visuals, and files open questions and decisions where the project keeps them | v1.0 |
| [`feature-delivery-loop`](skills/feature-delivery-loop/) | Takes an approved spec through plan, build (one task at a time), second-pass UI and backend reviews, test, PR review, and a docs update. Reviews report first and never edit until you approve | v1.0 |

## Install

**As a plugin (recommended, all six at once)**
- Claude Code: `/plugin marketplace add fareezidzuan/project-workflow-skills`, then `/plugin install project-workflow-skills@project-workflow-skills`.
- **Updates:** in `/plugin` → **Marketplaces**, select this marketplace and choose **Enable auto-update**. Or update by hand with `/plugin marketplace update project-workflow-skills`.
- Claude apps that support plugins: add this repo as a plugin source, or upload the plugin from **Releases**.

**As separate skills**
Download the repo (**Code → Download ZIP**), then add each folder in `skills/` as a skill. Keep `project-repo-setup` installed: the others read its `references/conventions.md`. Each skill still works alone with its own defaults.

## Getting started: one project, start to finish

1. **Set up the project:** "Set up a new project for a café website."
   You get a workspace (`01-meeting-notes/`, `03-media/`, `05-design-files/`, `06-brand-assets/` …) and a repo with `CLAUDE.md` and docs. At the end, it offers the next two steps.
2. **Process the kickoff meeting:** "Meeting notes from my last Fireflies call."
   The note is saved to `01-meeting-notes/260120-kickoff.md`. Decisions go to `docs/decisions/`, tasks to `docs/TODO.md`, and questions to `docs/OPEN-QUESTIONS.md`, each only after you approve.
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

## Make it yours
In `skills/project-repo-setup/references/`, copy `house-defaults.example.md` to `house-defaults.md` and fill in your conventions (meeting-note format, where repos live, languages). Keep that file private.

## Licence
MIT — see [LICENSE](LICENSE).
