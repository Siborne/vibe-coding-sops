# Branch & PR Workflow Rule — Design Spec

**Date:** 2026-05-17
**Status:** Approved

## Overview

Add a new rule to vibe-coding-sops: **分支与 PR 工作流规则** (`rules/branch-pr-workflow.md`).

Covers the full lifecycle: create branch → write code → open PR → review → merge → cleanup.

## Rule File Structure

Single file: `rules/branch-pr-workflow.md`, organized in 5 sections:

### 1. Branch Naming Convention

Format: `<type>/<short-description>`

| type | Use | Example |
|------|-----|---------|
| `feat` | New feature | `feat/user-login` |
| `fix` | Bug fix | `fix/login-timeout` |
| `refactor` | Refactor (no behavior change) | `refactor/extract-auth` |
| `docs` | Documentation | `docs/api-guide` |
| `chore` | Misc (deps, config) | `chore/update-deps` |
| `test` | Test-only changes | `test/add-login-spec` |

Constraints:
- description: kebab-case, lowercase English, max 4 words
- No username or ticket number unless team has a unified ticketing system

### 2. PR Scope Definition

Core principle: one PR = one semantically complete change.

- Must be describable in one sentence
- Main must not be in a "half-done" state after merge
- No unrelated changes (no piggyback refactoring, formatting)
- Guidance: typically 200–800 lines; above 2000, consider splitting
- Exceptions for mass renames / generated code — note in PR description

Split tip: data model PR first → business logic PR → UI/presentation PR last. Pure refactors go in their own PR.

### 3. Branch Sync Strategy

Rebase-first, linear history.

- Daily: `git fetch origin && git rebase origin/main`
- Pre-merge: rebase onto latest main, ensure CI still passes
- Forbidden: merge main into branch (reverse merge commit)
- Conflicts: resolve locally by functional semantics, re-run tests, then force-push
- Force-push allowed only on personal feature branches
- Shared branches: coordinate before rebase

### 4. Pre-Merge Checklist

**Layer A — Automated (must pass):**
- Lint
- Tests
- Build

**Layer B — Author self-check (before opening PR):**
- Change log created (`docs/变更记录/`)
- Commit message compliant (per commit-message rule)
- Happy path + at least one edge case tested locally
- No leftover debug code (console.log / print / TODO markers)
- PR description covers: what, why, risks

**Layer C — Review gate:**
- At least one collaborator approved
- All blocking comments resolved
- Post-review pushes require reviewer re-confirmation

### 5. Merge & Cleanup

- Reviewer executes merge (not author)
- Merge method: fast-forward or rebase-merge only (no squash merge, no `--no-ff` merge commit)
- After merge: delete remote branch immediately
- Author cleans up: `git fetch --prune`, delete local branch
- Post-merge bugs: open new `fix/` branch from main, never continue on the old branch

## Deliverables

1. `rules/branch-pr-workflow.md` — the rule
2. `rationale/branch-pr-workflow.md` — why this rule exists
3. Update `README.md` — add rule #7 to the index table and quick-start section
4. Update `CLAUDE.md` — add to the Rules to Load table
5. Change log in `docs/变更记录/`

## Dependencies

This rule intersects with existing rules:
- **commit-message rule** — checklist references it for commit compliance
- **code-change-log rule** — checklist requires change log before PR
- **code-review rule** — review principles apply to the PR review step
