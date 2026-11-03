# Plain language

Shared by every Project Workflow skill. Use it when any of these is true:
- the project's `CLAUDE.md` has `Explain: plain`;
- the project was set up as **Folders only** (`Git: none` in `CLAUDE.md`);
- the user says they are new to GitHub, Git, code or the terminal, or asks what a term means.

The user is usually a designer. They know Figma, layers, versions and handoff; they may not know Git.

## Rules
1. **Outcome first.** Say what will happen in their files ("I'll create 7 folders in Client Projects/Cafe"), then the detail.
2. **Swap the jargon** using the table below. Use the technical word only when the user will see it on screen (a button, a file name), and explain it once in a few words.
3. **No commands unless needed.** Don't show terminal commands, git commands or file paths in code blocks unless the user must run or type them. When they must, say where to paste it and what they will see, in one line each.
4. **One analogy per new idea**, only the first time it comes up. Don't stack analogies.
5. **Show, don't list.** Prefer a short tree of folders or a before/after over a table of technical fields. Keep the approval gates; just word them plainly ("Shall I create these folders?").
6. **Never make Git or GitHub a blocker.** Everything in these skills works without them. Offer "add version history later (Git)" as an option, never a requirement.
7. **Errors in human terms.** "I can't open that folder yet. In Claude, choose the folder when it asks for access, then say 'try again'." Not a stack trace.

## Words to swap

| Instead of | Say | Analogy (first time only) |
|---|---|---|
| repo, repository | project code folder (with version history) | Like a Figma file with version history: every saved version can be reopened |
| Git | version history for files | Figma's version history, for a whole folder |
| GitHub | online backup and sharing for the code folder | Like Figma's cloud: the shared copy everyone opens |
| commit | save a named version | "Save to version history" in Figma, with a label |
| push | upload your saved versions to GitHub | Publishing a library update so others get it |
| pull | download the latest versions | Accepting library updates |
| branch | a separate working copy | Duplicating a page to try an idea without touching the main one |
| merge | combine the copy back into the main version | Moving the approved frames back onto the main page |
| pull request (PR) | a request for someone to review and accept changes | Sending a frame for review before it goes into the master file |
| clone | download a copy of the project code folder | Duplicating a shared file to your drafts |
| `.gitignore` | list of files that never get shared | A "private, don't publish" list |
| workspace | project folder for raw files | Your project's shared drive folder |
| `CLAUDE.md` | the project's notes file for Claude | A cover page that tells Claude how this project works |
| markdown (`.md`) | a plain text file with simple formatting | — |
| terminal, command line | a text window where you type instructions | — |
| scaffold | create the starting folders and files | Setting up a new file from a template |
| path | folder location | — |
| token (design) | a named design value, like `color-primary` | A Figma variable |
| environment variable, secret, key | a private setting such as a password (never paste it into chat) | — |

## Recording the preference
When setup asks "How familiar are you with Git and GitHub?", record the answer in the workspace (and repo) `CLAUDE.md`:
- New to it → `Explain: plain`
- Some or comfortable → `Explain: standard`

Other skills read this line; don't ask again.
