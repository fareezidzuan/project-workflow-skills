# Security document templates

Used by `security-docs` step 4, and by the project-repo-setup health check (group C) to judge whether a security document is complete. Leave out sections that do not apply and say why in one line. Every document starts with the same header:

```markdown
# <Title> — <project>
Version: <commit or release> · Updated: <yyyy-mm-dd> · Owner: <name>
Reads: <earlier documents this one depends on>
Status: Draft | Agreed | Needs update
```

## 1. `app-brief.md`

```markdown
## What the app does
<1–2 lines>

## Who uses it
| Role | Who | How they sign in |
|---|---|---|

## What it stores
| Data | Example | Sensitive? | Source |
|---|---|---|---|

## Stack and services
| Part | Tool | Found in |
|---|---|---|
| Frontend | | |
| Backend / API | | |
| Database | | |
| Auth | | |
| File storage | | |
| Hosting | | |
| Third-party services | | |

## Important actions
- <action that moves money, changes access, exposes private data, or costs money>

## Unknown
- <line> — <who can answer>
```

## 2. `security-rules.md`

```markdown
## Scope
<features and endpoints covered; what is out of scope>

## Rules
| # | Rule | Applies to | Enforced where | Test | Status |
|---|---|---|---|---|---|
| R1 | Server checks all input; extra fields are ignored | <form / endpoint> | <file or policy> | Send an extra `role=admin` field; saved role is unchanged | Planned / Built / Verified |

## Open questions
- <question> — <who answers>
```
Cover at least: server-side input checks, safe database queries, secrets kept out of browser code, upload limits (type, size, scanning) if uploads exist, rate or cost limits on expensive actions, and error messages that reveal no internals.

## 3. `auth.md`

```markdown
## Login
<provider or framework, methods (password, magic link, SSO, MFA), session length>

## Permission table
| Role | View | Create | Change | Delete | Checked where |
|---|---|---|---|---|---|

## Account and session lifecycle
| Event | What happens | Existing sessions | Existing links / tokens | Test |
|---|---|---|---|---|
| Invitation | | | | |
| Password or account recovery | | | | |
| Role change | | | | |
| Access removed | | | | |

## Tests
- Allowed: <user A does X on A's record>
- Denied: <user B tries X on A's record, by ID or URL>
- Removed: <after A's access is removed, A's session and links>

## Open questions
```
Mark provider behaviour that was not confirmed as `Unverified`.

## 4. `data-security.md`

```markdown
## Data inventory
| Data | Purpose | Stored in | Copies (previews, logs, backups, services) | Who can access | Kept for | Deleted how |
|---|---|---|---|---|---|---|

## Protection rules
| # | Rule | Enforced where | Test | Status |
|---|---|---|---|---|

## Deletion and backups
<what "delete" removes in active storage, previews and caches; when backup copies expire; what the app cannot delete>

## Open questions
```
Include logs (no private content or credentials), outside services that receive data, and encryption or secret-management features the tools actually support. Retention periods the law or the client sets go under Open questions until confirmed.

## 5. `threat-model.md`

```markdown
## Most important risks
| # | Risk (who could do what) | Needs to be true | Harm | Protection | Test | Owner | Type | Status |
|---|---|---|---|---|---|---|---|---|
| T1 | A signed-in customer changes a file ID to read another customer's file | IDs are guessable; no ownership check | Private data exposed | Server checks ownership before returning the file | Repeat the request as the wrong customer | <name> | Possible / Found in code | Open / Fixed / Verified |

## Changes needed in other documents
- <document> — <missing rule>

## Accepted risks
- <risk> — <why accepted> — <decision link>
```
Start with the three most realistic, most harmful scenarios. Add more as the app grows.

## 6. `security-checklist.md`

```markdown
## Test setup
Environment: <test / staging> · Version: <commit> · Test data: fake records only · Run by: <name>

## Checks
| # | Check | From | Setup | Action | Expected | Actual | Result | Evidence | Blocks launch |
|---|---|---|---|---|---|---|---|---|---|
| C1 | Cross-account file access | auth.md, T1 | Customers A and B, each with a private file | B requests A's file | Access denied, no content returned | | NOT RUN | | Yes |

## Runs
### <yyyy-mm-dd> — <version>
PASS n · FAIL n · BLOCKED n · N/A n · NOT RUN n
Launch blockers open: <list or none>
```
Every check starts as `NOT RUN`. `N/A` and `BLOCKED` need a reason. Another person must be able to follow each row without guessing.

## Stack add-ons (add the rows that match the app brief)

| Stack part | Add to | Rows |
|---|---|---|
| Supabase / Postgres | auth, rules, checklist | Row-level security on every table with user data; policies per role; `service_role` key only on the server; storage bucket policies; check with two test users through the client SDK, not the dashboard |
| Firebase | auth, rules, checklist | Firestore and Storage security rules per collection; rules tested in the emulator; admin SDK only on the server |
| Own backend / REST or GraphQL API | rules, auth, checklist | Auth middleware on every route; ownership check per record; input schema validation; rate limits; CORS allow-list; no stack traces in responses |
| Client-owned backend or API (the app calls an API another team runs) | all | "Enforced where" names the client's system and is `Unverified` until they confirm; masking of personal data in API responses (full IC or card numbers never sent to the browser); staff roles and audit log owned by whom; related checks stay `BLOCKED` until the client provides a test environment |
| Serverless / edge functions | rules, data | Secrets in platform env settings; caller verified inside the function; timeouts and cost limits |
| Payments (Stripe, payment gateway) | rules, data, threat model | Card data never touches the app; webhook signatures verified; amounts set on the server |
| File uploads | rules, data | Type and size limits; private buckets; signed URLs with short expiry; previews deleted with originals |
| AI / LLM APIs | rules, data, threat model | API key server-side; user content sent to the provider listed in the data inventory; prompt injection from user content; per-user usage limits |
| Email, SMS, analytics, CRM | data | What each service receives; whether it is needed; how to delete it there |
| Mobile app (iOS / Android) | rules, data | Tokens in Keychain / Keystore; no secrets in the app bundle; certificate pinning decision |
| Banking or regulated client | data, open questions | Client security policy, PDPA, BNM RMiT, PCI DSS: list as open questions with the client owner; never state requirements from memory |
