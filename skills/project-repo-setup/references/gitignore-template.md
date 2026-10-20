# .gitignore template and safety scan

## Template: base blocks (always) + stack blocks (pick what applies)

```gitignore
# --- Secrets (always) ---
.env
.env.*
!.env.example
*.pem
*.key
*.p8
*.p12

# --- Claude (always) ---
# Share commands, rules, settings.json and launch.json; keep personal files out.
# Never use ".claude/*": new rules would silently stop being shared.
.claude/settings.local.json
.claude/worktrees/

# --- OS (always) ---
.DS_Store
Thumbs.db

# --- Design sources and raw inputs: safety net (always) ---
# These belong in the workspace, not the repo.
*.fig
*.psd
*.ai
*.sketch
*.xd
*.mp4
*.mov
*.zip
# Exception example for a small video the site really serves:
# !public/videos/hero.mp4

# --- Stack blocks (include only what applies) ---
# Node / Next / Nuxt
node_modules/
.next/
.nuxt/
.output/
out/
dist/
*.tsbuildinfo
next-env.d.ts

# Swift / Xcode
xcuserdata/
DerivedData/
build/
.swiftpm/
*.ipa
*.xcarchive

# Android / Gradle
.gradle/
local.properties
*.apk
*.aab

# Supabase CLI scratch
supabase/.branches
supabase/.temp
```

`.claude/launch.json` is shared. The safety scan flags absolute or personal paths inside it; fix with relative paths or environment variables.

## Safety scan
**Runs:** before the first commit, before every push, in health check group C, and during a Step 2 audit.

List what would be committed (tracked plus untracked, not ignored) and report `Finding | Path | Fix`:
- Secret file names: `.env*` (not `.env.example`), `*.pem`, `*.key`, `*.p8`, `*.p12`, `id_rsa*`, names containing `credential`, `secret`, `password`, `token`.
- Key patterns inside text files: `AKIA`, `sk-`, `sk-ant-`, `sk_live_`, `ghp_`, `xoxb-`, `AIza`, `BEGIN PRIVATE KEY`, JWT strings (`eyJhbGci…`), `service_role`.
- Tracked files that now match `.gitignore` (gitignore does not untrack) → `git rm --cached <file>` after approval.
- Personal absolute paths (`/Users/<name>/`, `C:\Users\<name>\`, `/home/<name>/`) in tracked files, except the inputs line in `CLAUDE.md`.
- Recordings, video, archives, design source files, exports.
- Any file over 25 MB (GitHub warns at 50 MB and blocks at 100 MB).

**Fix** by moving the file to the workspace or adding it to `.gitignore`, using the impact preview.

## History scan (file contents)
- **Command:** `git log --all -p -G '<patterns>'` over the key patterns above. If a dedicated secret scanner (for example gitleaks) is installed, use it instead.
- **First run:** full history. Estimate the time from the commit count and ask before starting on large repos.
- **Later runs:** only `<last-scanned-commit>..HEAD`; the last scanned commit is recorded in the health-check section of the session log.
- **Output:** commit, file, pattern type. Mask the value (`sk-ant-••••3f2a`); never print a secret in full.
- **A secret in history** goes in "Can't be fixed here": rotate the key first. Rewriting history is offered only as an advanced option, with a warning that it breaks every clone and open branch.
