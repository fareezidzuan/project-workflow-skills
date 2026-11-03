# Changelog

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
