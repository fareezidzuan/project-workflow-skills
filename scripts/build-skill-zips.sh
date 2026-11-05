#!/usr/bin/env bash
# Build one ZIP per skill, plus one plugin ZIP with every skill, for people
# who install by upload (Claude desktop and web apps, Cowork) instead of the
# Claude Code plugin command.
#   <skill>.zip                        upload as a skill (one folder, SKILL.md inside)
#   project-workflow-skills-plugin.zip upload as a plugin (every skill)
#
# Each skill ZIP gets copies of the shared files from project-repo-setup
# (conventions.md, plain-language.md) so it still works when uploaded on
# its own. Edit those files only in skills/project-repo-setup/references/.
#
# Usage: scripts/build-skill-zips.sh [out-dir]   (default: dist)
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="${1:-dist}"
case "$out" in /*) ;; *) out="$root/$out" ;; esac
shared_dir="$root/skills/project-repo-setup/references"
shared=(conventions.md plain-language.md)
bundle="project-workflow-skills-plugin"

stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
rm -rf "$out"
mkdir -p "$out" "$stage/$bundle/skills"

for dir in "$root"/skills/*/; do
  name="$(basename "$dir")"
  dest="$stage/$name"
  # Copy the skill, leaving out personal settings and system files.
  cp -R "$dir" "$dest"
  find "$dest" \( -name 'house-defaults.md' -o -name '.DS_Store' \) -delete
  mkdir -p "$dest/references"
  for f in "${shared[@]}"; do
    [ -f "$dest/references/$f" ] || cp "$shared_dir/$f" "$dest/references/$f"
  done
  cp "$root/LICENSE" "$dest/LICENSE"
  (cd "$stage" && zip -qr "$out/$name.zip" "$name")
  cp -R "$dest" "$stage/$bundle/skills/$name"
  echo "built $name.zip"
done

cp -R "$root/.claude-plugin" "$stage/$bundle/.claude-plugin"
cp "$root/README.md" "$root/LICENSE" "$stage/$bundle/"
(cd "$stage/$bundle" && zip -qr "$out/$bundle.zip" .)
echo "built $bundle.zip"
