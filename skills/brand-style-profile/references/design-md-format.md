# Project DESIGN.md format

The sections the brand-style-profile skill writes into a project's `DESIGN.md`. They are also what the [project-design-kraf](https://github.com/fareezidzuan/project-design-kraf) skills read. Keep any content the file already has; add these sections below it.

Every value carries its source: **Figma**, **Code**, **Guide** (brand PDF), **Measured** (website), **Estimated** (image), or **Proposed** (no source; needs confirmation).

The example below is a made-up brand.

```md
# Craft layer

## Brief — Proposed
who: neighbours ordering bread for pickup, on a phone, the evening before
job: see tomorrow's bake and reserve a loaf before it sells out
feel: warm and plain, like a chalkboard menu by the oven
context: phone first; quick visits; one batch a day

## Direction — Proposed
signature: tomorrow's bake written as a chalkboard list, crossed out as loaves sell
depth: tone-steps (no shadows at rest)
density: balanced, spacing base 8
accent rule: Rye red for the reserve button and sold-out marks only

## Colour — Figma
ground: #F4EFE6   (Flour)
ink: #2B211B      (Crust)
ink-2: #5E4B3F
muted: #9C8B7E
accent: #A63A2B   (Rye)
positive: #3F7D4E  negative: #A63A2B  warning: #C98A1B
dark mode: not in scope

## Shape — Code
radius: controls 6 · cards 12 · sheets 20

## Typography — Figma
families: Fraunces (display), Inter (UI)
display: 40/44/600/-0.02em
title: 24/30/600/-0.01em
body: 16/24/400
label: 14/18/500
caption: 12/16/400
figures: tabular for prices and pickup times

## Motion — Proposed
personality: calm
ease-out: cubic-bezier(0.23, 1, 0.32, 1)
durations: fast 120, quick 180, base 240, slow 320

## Domain rules — PLACEHOLDERS
allergens: [TODO: how allergens must be listed]
pricing: [TODO: tax-inclusive wording]

## To resolve
1. Code uses #A83C2C for the reserve button; Figma "Rye" is #A63A2B.
2. Two Figma styles named "Title/M" (20pt and 22pt).

## Decisions
| Date | Decision | Why |
|---|---|---|
| 2026-11-02 | Sold-out loaves stay visible, crossed out | People check what they missed |
```

## Rules

- Never overwrite existing content; merge or append.
- Never invent domain rules (banking, health, legal, allergens). Leave TODO placeholders.
- List every Figma/code mismatch under "To resolve"; don't choose a side.
- A `DESIGN.md` may hold client details: keep it in that project's own repo.
