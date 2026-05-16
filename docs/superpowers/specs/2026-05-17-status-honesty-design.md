# Status Honesty Rule — Design Spec

**Date:** 2026-05-17
**Status:** Approved
**Topic:** New vibe coding rule — AI must honestly report completion status

## Overview

AI assistants tend to overstate completion: code written ≠ done. This rule requires AI to report one of four explicit states and prohibits claiming DONE without verification evidence.

## Rule Design

### 1. Core Requirements

**Prohibit false completion claims.** Writing code is not "done." If tests haven't been run, key paths haven't been verified, or the work can't be confirmed, the AI must explicitly say so.

**Four required statuses:**

| Status | Meaning |
|--------|---------|
| `DONE` | Implementation + verification + tests all complete |
| `PENDING VERIFICATION` | Code written but not yet tested or verified |
| `BLOCKED` | Hit an unsolvable problem, needs human intervention |
| `PARTIAL` | Completed part A, parts B/C not yet started |

**DONE requires evidence, not just assertion.** A claimed-DONE response must include a verification checklist showing what was tested and how.

**User feedback rule.** When the user says something doesn't work / is wrong / is incomplete, the AI must:
- Not defend or retry the same approach (unless explaining why this time is different)
- First reproduce the problem, then confirm root cause, then fix

### 2. Implementation Mechanism

**Status block at end of every response (when code was changed):**

```
---
Status: PENDING VERIFICATION
Done: edited rules/status-honesty.md, created rationale/status-honesty.md
Not done: README.md and CLAUDE.md not yet updated
Next: run git diff to confirm changes are correct
```

**DONE requires a verification checklist:**

```
---
Status: DONE
Done: added rule file, rationale file, updated README, updated CLAUDE.md
Verification:
[x] Rule file exists and is complete
[x] Rationale file exists
[x] README.md updated with rule #7 entry
[x] CLAUDE.md Rules to Load table updated
[x] git diff shows only intended changes
```

**When user reports issues — required downgrade:**
- Status must drop to `BLOCKED` or `PENDING VERIFICATION`
- First response: reproduce and confirm the problem
- Do not reuse a failed approach without explaining why it'll work this time

### 3. Scope and Boundaries

**Applies to:**
- All tasks that produce code changes (bug fixes, features, refactoring, docs)
- Multi-turn sessions where code was touched

**Does NOT apply to:**
- Pure Q&A / informational queries with no code output
- When user explicitly says to skip the status block

**Edge cases:**

| Scenario | Requirement |
|----------|-------------|
| AI unsure if truly done | Default to `PENDING VERIFICATION` |
| User changed direction mid-task | Report `PARTIAL`, list what's done vs. discarded |
| Task too large, session ended | End with `PARTIAL` + concrete next step |
| AI made a mistake, user called it out | Downgrade to `BLOCKED` or `PENDING VERIFICATION` |

## Rationale (for rationale/ file)

### Trigger Scenario

AI writes 3 files, claims "done." User tries to run — one file has a hallucinated API call, another silently swallows errors. AI's "done" statement convinced the user to move on without checking. Bug found in production two weeks later.

### Core Problem

AI treats "code written" as "task complete." But code that hasn't been verified is just a draft. Without explicit status reporting, users can't tell the difference between "I wrote it" and "I confirmed it works."

### Why It Matters More in Vibe Coding

Manual coding has natural checkpoints: you write, you compile, you run. AI coding collapses these into seconds. The speed makes it easy to skip verification — both the AI and the user feel productive, but the output is unvalidated.

### Consequences Without This Rule

- AI claims done, user trusts it, unverified code reaches production
- User learns to distrust AI's status reports, double-checks everything anyway (defeats the purpose)
- Team velocity illusion: lots of "done" tasks that aren't actually done

## Implementation Plan (Next)

1. Create `rules/status-honesty.md` — the rule file
2. Create `rationale/status-honesty.md` — the rationale
3. Update `README.md` — add rule #7 to index
4. Update `CLAUDE.md` — add to Rules to Load table
5. Update README badge to `rules-7`
