# Why GitHub PR Workflow

## Trigger Scenario

An Agent working on a shared GitHub repository commits directly to `main` and pushes. Only afterwards it realizes: CI failed, tests didn't pass, and no reviewer has seen the code — yet `main` is the stable branch everyone depends on. The change lands on trunk, and every collaborator's local `main` is instantly out of sync with remote.

Another scenario: the Agent develops on a feature branch but forgets to request reviewers, skips the linter, or merges with coverage below the threshold. The code reaches `develop`, the team review reveals a logic gap, and rework follows.

## Core Problem

An Agent's default tendency is "commit once it looks done", because each individual step seems to advance the task. But correctness in a multi-contributor repository depends not on "does the code run" but on "did it pass the agreed process".

Without a fixed Git collaboration workflow, Agent behavior becomes erratic:

- Sometimes commits straight to `main`, breaking the stable branch
- Sometimes forks / branches / PRs come out confused, with the PR targeting the wrong branch
- Sometimes tests, linter, and coverage are skipped, merging unverified code
- Sometimes reviewer comments are ignored and the merge proceeds

The problem is not any single action but the **inconsistency of process run-to-run**. The rule's job is to make the Agent follow one predictable, auditable pipeline on every collaboration task.

## Why a Dedicated Skill Rather than an Ad-Hoc Prompt

**The workflow has many steps with ordered dependencies.** A full Fork → Feature Branch → PR → Review → Merge pipeline has 20+ stages, each with preconditions. Writing "remember to use the PR workflow" in a prompt is far from enough — the Agent skips critical checks at the stages that "feel about right".

**The contract must be reproducible.** Fork-first, develop-based, `feature/*` naming, Squash and Merge, 2 LGTM, no force-push to `main` — these are strong enterprise constraints. Encapsulating them as a skill lets any Agent loading the repo adopt the same standard, independent of the contributor's Git fluency.

**The cost of process failure is asymmetric.** One correct pipeline run costs only a few extra commands, but a single bad `push --force main` or a "merge without review" can double the whole team's rollback cost. The skill forces these low-probability, high-consequence operations behind a mandatory gate.

## Relationship to rules/branch-pr-workflow.md

This skill and the repository's "Branch & PR Workflow rule" (`rules/branch-pr-workflow.md`) jointly govern Git collaboration but serve different roles:

- **rule** defines the **principles and checklists that must hold**: branch naming format, PR scope, rebase-first, the A/B/C pre-commit checklist, reviewer merge and cleanup.
- **skill** provides the **executable operation sequence**: from Fork/Clone to Feature Branch, from tests/coverage/lint to PR description/Reviewers, down to Squash & Merge — step-by-step commands and gates.

Together: the rule governs *what must be true*, the skill governs *how to execute it step by step*.

## Consequences Without This Skill

- Agent operates directly on `main`, breaking the stable branch and losing sync
- PR process becomes ceremonial: no reviewer, no CI, no coverage, review is a formality
- Commit messages and branch names drift, history becomes untraceable
- Collaboration norms live only in word-of-mouth; new Agents/members cannot auto-adopt a uniform process
- High-risk operations (force push, skipping review) have no mandatory interlock, so mistakes are costly
