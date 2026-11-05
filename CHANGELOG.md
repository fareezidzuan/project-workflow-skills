# Changelog

## 1.6.0 — 2026-11-05
- **feature-brief v1.0 (new):** writes one feature spec in `docs/features/` with the project's spec header (Status, Inputs, Untraced), the inputs access rule, and Figma-wins-visuals precedence. Open questions and decisions go where the project keeps them.
- **feature-delivery-loop v1.0 (new):** plan, build one task, second-pass UI and backend reviews, test, PR review, update docs. Reviews report first and never edit until approved. The backend review reads `docs/security/`. In Folders-only projects it offers to add Git before building.
- Both new skills follow the shared-files and plain-language rules from 1.5.0, and get their own release ZIPs.
- **meeting-notes v1.5:** new handoff to `feature-brief`.
- **project-repo-setup:** handoff line only; version stays v2.3 so the health check doesn't flag every project's setup stamp as outdated.
- Works-with block in every skill lists all six; README, download links, `plugin.json` and marketplace description updated.

## 1.5.0 — 2026-11-03
For designers with no GitHub experience.

- **Install without Git:** README install steps for the Claude desktop and web app, Cowork, and Claude Code. Release ZIPs (one per skill, plus a plugin ZIP with all four) are built and attached to each GitHub release by `.github/workflows/release-zips.yml` (`scripts/build-skill-zips.sh`).
- **Skills work when uploaded alone:** each skill ZIP carries copies of `conventions.md` and `plain-language.md`; skills look in their own `references/` first.
- **project-repo-setup v2.3:** new **Folders only** setup (no Git or GitHub; docs in `<workspace>/docs/`), **Add Git later**, designer trigger phrases ("start a new client project", "organise my project files"), a Git-familiarity question recorded as `Explain: plain | standard`, and a fallback for apps with no folder access. The `CLAUDE.md` setup stamp now matches the skill version (was v2.1 / v2.0).
- **conventions.md:** section 0 (where project docs live, `Git:` and `Docs:` lines); decision template included so skills can log decisions without slash commands.
- **plain-language.md (new):** tone rules and a glossary of Git terms with Figma analogies, used by every skill.
- **meeting-notes v1.4, brand-style-profile v1.3, security-docs v1.1:** write to the project's `Docs:` folder, work in Folders-only projects, log decisions directly when `/log-decision` is unavailable, follow `Explain: plain`.
- **docs/starter-prompts.md (new):** things to say, grouped by task.

## 1.4.0
- brand-style-profile v1.2: codebase tokens, Figma/code reconcile, project `DESIGN.md` output.
