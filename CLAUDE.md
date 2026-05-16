# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`vibe-coding-sops` stores rules for AI-assisted coding (vibe coding). Each rule defines what to do and how (`rules/`), paired with a rationale explaining why (`rationale/`).

**When this repo is loaded into your project's context, you must follow all rules in `rules/`.**

## Repository Structure

```
rules/          # Rule files — what to do, how to do it, with examples
rationale/      # Rationale files — why the rule exists, consequences of skipping it
README.md       # Rule index with badges and quick-start guide
LICENSE         # MIT
```

## Rules to Load

| Rule | File | Core Requirement |
|------|------|-----------------|
| Code Change Log | `rules/code-change-log.md` | After every Edit/Write, create a change log in `docs/变更记录/` with root cause analysis and before/after code |
| Meaningful Comments | `rules/meaningful-comments.md` | Comments explain WHY not WHAT; 7 types: TODO, references, correctness, lessons learned, constants, load-bearing details, "why not X" |
| README Structure | `rules/readme-structure.md` | Funnel: what → why care → how to use → how to install; show usage before install steps |
| Commit Messages | `rules/commit-message.md` | Commit body answers: what problem, alternatives considered, tradeoffs, surprises |
| Code Review | `rules/code-review.md` | Review code not people; actionable suggestions; ask don't command; explain why; label blocking vs suggestion; praise good work; know when to stop |

## Adding a New Rule

1. Create `rules/<slug>.md` — rule description + examples (no rationale in the rule file)
2. Create `rationale/<slug>.md` — motivation, context, consequences
3. Add to README.md index table
4. Add to the Rules to Load table in this CLAUDE.md

## Self-Application: This Repo's Own Change Log

This repo's rules apply to Claude Code when editing THIS repo. Specifically:

**Every time you modify files in this repo, create a change log in `docs/变更记录/`.**

Naming: `<brief-description>_<YYYY-MM-DD>.md`

The change log must include:
- **What** was changed (files, sections)
- **Why** the change was made (user request, rule clarification, fix)
- **Before/After** if the change is a rewrite or structural change

This ensures the evolution of the rules themselves is traceable — the meta-rule applies to its own home.
