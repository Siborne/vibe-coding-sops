# Why Expert AI Rules Matter

## Trigger Scenario

The AI is asked to change a button label and refactors the surrounding component; the user asks "is this approach okay?" and gets three options and a dozen bullets with no conclusion; the AI invents a non-existent API and says "it should work"; the project's `CLAUDE.md` grows longer and longer until nobody reads or maintains it.

These are not failures of model capability. They are failures of collaboration constraints. The 11 public rule files all answer the same question: **how do we make AI output feel like a reliable colleague instead of a text generator rushing to finish?**

## Core Problem

Language models are optimized to produce the most statistically likely continuation, not the most useful answer for this particular person and task. That default skews toward:

- Writing more rather than less, because more looks complete
- Bullets rather than prose, because bullets look structured
- Agreeing rather than disagreeing, because agreement is safer
- Guessing rather than admitting uncertainty, because guessing reads fluently
- Touching more code, because "while I'm here" looks proactive

None of these is catastrophic alone. Together they make AI collaboration hard to control: diffs grow, clarification happens late, and users can no longer tell which sentence is a fact and which is a guess.

## What These Rules Solve

- **Think before acting**: surface assumptions and success criteria early, reducing rework caused by a misunderstood task.
- **Do the right amount**: keep diffs minimal and boundaries explicit, protecting the user's existing code and work.
- **Communicate clearly**: conclusion first, natural prose, one question at a time.
- **Respect boundaries**: confirm external actions, deletions, and shared-repository operations before they happen.
- **Stay maintainable**: keep rule files readable, separate rules from facts, and add rules after real failures instead of stacking slogans.

## Why a Skill, Not a Rule

This repository's `rules/` are atomic constraints: one rule solves one problem. This material covers 12 topics, from coding and questioning to writing and Git operations. Turning it into a single rule would break atomicity and duplicate existing rules such as `uncertainty-marking`, `status-honesty`, and `code-review`.

It is therefore stored as an atomic skill: a reusable set of collaboration principles and templates. It does not replace any existing rule. The rules keep enforcing specific constraints; this skill provides the overall behavioral baseline and the raw material for project-level rule files.

## Consequences Without These Rules

- The AI guesses what the user wants every time; clarification happens after mistakes, not before work starts.
- Unrelated changes leak into diffs, raising review cost and widening the rollback surface.
- Answers get longer and more template-like; users have to dig through bullets to find the conclusion.
- The AI agrees to be polite, and a bad approach survives until implementation.
- Rule files grow into an unmaintained list of slogans.

## Boundaries

- These are default behaviors, not project facts. Commands, directories, and stacks must come from the current project.
- The user's current explicit instruction overrides any rule file.
- Safety, data loss, and external publishing always require confirmation.
- Rules must be verifiable; do not put unverifiable slogans into project-level rules.
