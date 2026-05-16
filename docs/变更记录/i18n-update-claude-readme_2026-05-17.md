# i18n: Update CLAUDE.md and README.md for bilingual structure

## What Changed

**CLAUDE.md:**
- Added `rationale/zh/` entry in Repository Structure code block
- Refreshed 6 rule descriptions in Rules to Load table to align with rewritten English rules
  - Meaningful Comments, README Structure, Commit Messages, Code Review, Code Style Declaration descriptions updated to use MUST-style language
  - Rows 7-9 (Status Honesty, Uncertainty Marking, Branch & PR Workflow) left unchanged

**README.md (complete rewrite):**
- Changed from Chinese-first to English-first with bilingual elements
- Badge updated: `rules-9` changed to `rules-6`, added `lang-en--CN` badge
- New bilingual tagline with Chinese note pointing to `rationale/zh/`
- Why You Need This section rewritten in English with Chinese pointer
- Quick Start code block simplified to English with 6 rules
- Rule Index table condensed to 6 English rules
- Repository Structure now shows `rationale/zh/` subtree
- License line added back

## Why

Part of the i18n plan (Tasks 19-20). The repo now has bilingual rationale (English + Chinese), and the README should reflect this with:
- English-first presentation (rules are English, AI executes them)
- Chinese as a secondary reference (rationale/zh/ for human readers)
- CLAUDE.md now acknowledges the bilingual rationale structure

## Before/After Summary

**CLAUDE.md Repository Structure:**
- Before: omitted `rationale/zh/`
- After: includes `rationale/zh/   # Rationale files (Chinese, reference)`

**CLAUDE.md Rule descriptions:**
- Before: varied language style (some crisp, some verbose, mixed Chinese)
- After: unified MUST-style English, consistent terminology

**README.md:**
- Before: fully Chinese, 9 rules including newer additions
- After: English-first bilingual, 6 core rules, rationale/zh/ pointer
