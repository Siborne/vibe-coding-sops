# Why Uncertainty Marking Matters

## Trigger Scenario

AI is asked to add user authentication. It writes `import { AuthClient } from '@company/auth-sdk'` and calls `AuthClient.authenticate()`. The import path doesn't exist, the method signature is wrong, and the SDK is actually called `@company/identity`. The user doesn't discover this until runtime — the AI's code "looked right" so it was never questioned.

## Core Problem

AI models don't know what they don't know. When uncertain about a library or business rule, they predict the most statistically likely answer — which is often a convincing hallucination. Without explicit marking, the user can't distinguish "I know this is correct" from "this is a plausible guess."

## Why It Matters More in Vibe Coding

In manual coding, you feel uncertainty: you pause, Google, ask a colleague. AI coding has no such friction — the model generates code instantly and confidently, regardless of whether it actually knows the answer. The speed eliminates the natural "wait, am I sure?" checkpoints that human developers rely on.

Three specific harms of hallucination:

- **Sunk cost**: The user continues developing on top of hallucinated code, with subsequent code depending on a non-existent API. Reverting requires undoing not just one line, but everything built on it
- **Trust degradation**: Each discovered hallucination erodes trust one level. Eventually the user verifies every line of AI output — negating the productivity gain entirely
- **Hidden debt**: Some hallucinations don't surface immediately (e.g., wrong default values) — they lie dormant until specific conditions trigger them

## Why Mandatory Tags Beat Trusting AI Self-Discipline

- **Minimal tagging cost**: Writing `[NEEDS VERIFICATION]` takes 3 seconds; eliminating a potential bug is worth far more
- **Auditable**: During code review, tagged code automatically receives higher scrutiny — the tag, not the AI, alerts the reviewer
- **Integration with Status Honesty**: Tag → `Uncertain` field → DONE blocked, forming a closed loop. AI cannot "forget" tagged code
- **Three paths cover everything**: Check / Mark / Ask — no gap in the decision space, AI won't skip because it "doesn't know what to do"

## Consequences Without This Rule

- Hallucinated APIs enter the codebase, failing only at runtime, wasting hours of debugging
- Wrong business assumptions become "established rules," referenced repeatedly in subsequent code
- Users learn to distrust AI output and verify every line — canceling the productivity gain
- The line between AI-generated and AI-verified blurs, making code review harder to prioritize
