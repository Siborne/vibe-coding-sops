# Why Status Honesty Matters

## Trigger Scenario

AI writes 3 files and claims "done." The user tries to run them — one file calls a non-existent API function, another silently swallows errors. The AI's "done" statement convinced the user to move on. The bug is found in production two weeks later.

## Core Problem

AI equates "code written" with "task complete." But unverified code is just a draft. Without explicit status reporting, the user can't tell the difference between "I wrote it" and "I confirmed it works."

## Why It Matters More in Vibe Coding

Manual coding has natural checkpoints: write → compile → run → verify. AI-assisted coding collapses these into seconds. The speed makes it easy to skip verification — both AI and user feel productive, but the output is unvalidated.

Three specific harms of fake completion:

- **Trust erosion**: After being burned twice by "done" claims, the user habitually questions every response, wasting more time verifying line by line
- **Context loss**: When the user believes "feature A is done" and starts assigning feature B, A's incomplete state is permanently buried — because subsequent conversations have already switched to B
- **Multi-turn amplification**: One round's fake completion becomes the next round's "completed foundation," with new code built on unverified old code, compounding errors

## Why Structured Status Blocks Beat Trusting AI Self-Discipline

- **Enforceable**: The status block is an explicit requirement, not a suggestion. A missing block is immediately visible
- **Auditable**: When reviewing conversations, each round's status block provides a clear progress snapshot
- **Four states cover everything**: DONE / PENDING VERIFICATION / BLOCKED / PARTIAL are mutually exclusive with no gray areas
- **Verification checklist prevents empty claims**: DONE status requires evidence — AI can't just "feel done"

## Consequences Without This Rule

- AI claims DONE but code doesn't run — users must manually verify every output
- Fake-completed code reaches production, with incidents traced back to unfinished AI code
- Team velocity illusion: a pile of DONE tasks where none are actually complete
- More subtly: subsequent code is built on "completed" but actually unfinished code, spreading errors
