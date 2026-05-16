# Uncertainty Marking Rule — Design Spec

**Date:** 2026-05-17
**Status:** Approved
**Topic:** New vibe coding rule — AI must explicitly mark uncertain code, never fabricate plausible answers

## Overview

AI assistants fabricate plausible-looking but incorrect code when uncertain: hallucinated API calls, guessed business rules, made-up defaults. This rule requires explicit marking of all uncertainty, with two tag types, and integrates with the Status Honesty rule to prevent DONE claims when unresolved marks exist.

## Rule Design

### 1. Core Requirements

**Two tag types:**

| Tag | When to Use | Example |
|-----|-------------|---------|
| `[NEEDS VERIFICATION]` | Unsure about API/library/syntax; wrote it but haven't confirmed it exists | Made up a `fetchUserData()` function name |
| `[ASSUMPTION: ...]` | Made a business-logic assumption without confirming with user | Assumed "orders auto-cancel after 30 min timeout" |

**Three permitted responses to uncertainty:**
1. **Check first** — if you can search/docs/verify, do that before writing
2. **Mark it** — if you can't confirm but must proceed, tag `[NEEDS VERIFICATION]`
3. **Ask** — if it's a business decision, tag `[ASSUMPTION: ...]` and ask the user

**Forbidden:**
- Fabricating non-existent APIs, libraries, or function signatures
- Passing off guessed business rules as established facts
- Making up "reasonable" defaults without telling the user you made them up

### 2. Marking Syntax

**Inline in code:**

```
// [NEEDS VERIFICATION] Unsure if this API exists — check docs before merge
const user = await auth.fetchUserById(userId);

// [ASSUMPTION: Assumed 30-minute order timeout — confirm with product]
if (Date.now() - order.createdAt > 30 * 60 * 1000) {
    cancelOrder(order);
}
```

**Each tag must include:**
- Tag type (`[NEEDS VERIFICATION]` or `[ASSUMPTION: specific assumption]`)
- Explanation: what's uncertain and why

### 3. Integration with Status Honesty

The status block gains an optional `Uncertain` field:

```
---
Status: PENDING VERIFICATION
Done: Implemented order cancellation logic
Uncertain:
- [ASSUMPTION: 30-min timeout] — orders.js L42
- [NEEDS VERIFICATION] — auth.fetchUserById — auth.js L15
Next: Confirm above tags before upgrading to DONE
```

**Hard gate:** Status CANNOT be `DONE` while any unresolved `[NEEDS VERIFICATION]` or `[ASSUMPTION]` tags remain in code.

**User clears tags by:**
- "That API is correct" → AI removes the tag
- "Change it to X" → AI fixes code + removes tag
- "All confirmed" → AI removes all tags, may upgrade to DONE

### 4. Scope and Boundaries

**Applies to:**
- All code-producing tasks
- Third-party library/API calls, business logic, data boundary handling especially
- Template/boilerplate code where AI is uncertain (even import statements)

**Does NOT apply to:**
- Pure Q&A / information queries
- Patterns inferred from the project's existing code (following existing conventions is not an assumption)

**Edge cases:**

| Scenario | Requirement |
|----------|-------------|
| AI is unsure but can check docs first | Check before marking — don't mark lazily |
| User says "just write it, I'll check later" | Keep tags, status stays `PENDING VERIFICATION` |
| AI was 100% sure but was still wrong | Not a rule violation — the rule governs knowing uncertainty, not unknown errors |
| More than 5 tags accumulated | Pause, ask user: confirm one-by-one vs. continue marking |
| Tags exist but `Uncertain` field is empty | Violates BOTH this rule and Status Honesty |
| AI wrote template code it's certain about | No tag needed |

## Rationale (for rationale/ file)

### Trigger Scenario

AI is asked to add user authentication. It writes `import { AuthClient } from '@company/auth-sdk'` and calls `AuthClient.authenticate()`. The import doesn't exist, the method signature is wrong, and the SDK is actually called `@company/identity`. User doesn't discover this until runtime — the AI's code "looked right" so they didn't question it.

### Core Problem

AI models don't know what they don't know. When uncertain about a library or business rule, they predict the most statistically likely answer — which is often a hallucination that looks convincing. Without explicit marking, the user can't tell the difference between "I know this is correct" and "this is a plausible guess."

### Why It Matters More in Vibe Coding

In manual coding, you feel uncertainty: you pause, you google, you ask a colleague. AI coding has no such friction — the model generates code instantly and confidently, regardless of whether it actually knows the answer. The speed eliminates the natural "wait, am I sure?" checkpoints that human developers rely on.

### Consequences Without This Rule

- Hallucinated APIs enter the codebase and fail at runtime, wasting hours debugging
- Incorrect business assumptions become "the way it works" and propagate through subsequent code
- Users learn to distrust AI output and manually verify every line — canceling the productivity gain
- The line between "AI-generated" and "AI-verified" blurs, making code review harder

## Implementation Plan (Next)

1. Create `rules/uncertainty-marking.md` — the rule file
2. Create `rationale/uncertainty-marking.md` — the rationale
3. Update `README.md` — add rule #8 to index, bump badge to rules-8
4. Update `CLAUDE.md` — add to Rules to Load table
5. Create change log in `docs/变更记录/`
