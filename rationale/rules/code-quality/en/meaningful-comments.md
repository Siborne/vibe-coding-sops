# Why Meaningful Comments

## The Trigger

You read a comment: `// validate input`. The code below it has three nested loops, a regex, and bitwise operations. The comment told you nothing. Then you see a bare constant `1492` sitting in the middle of a function. Is it arbitrary? Protocol-mandated? The result of an April debugging session? You have no way to know.

## The Core Insight: Comments' Enemy Is WHAT

Code naturally expresses WHAT — it's an executable description of steps. But code cannot express:

- Why this step, not the alternative
- What the boundary conditions are and why
- What was tried before and why it didn't work
- What will break if you change this

Comments should fill these gaps. A comment that merely translates code into natural language ("iterate the list, filter nulls" for `[x for x in list if x]`) is noise. Delete it.

## AI-Specific Risk

AI-generated code has a dangerous property: it always *looks* correct. Clean logic, good naming, perfect formatting — and this surface correctness makes real problems harder to spot.

**AI excels at writing useless comments.** Training data is full of `// increment counter` and `// validate input` — comments that restate WHAT. AI learned the form of commenting but not the substance. Without a filter, over half of AI-generated comments are noise, and the real WHYs go unrecorded. The seven-type taxonomy is that filter: if your comment doesn't fit one of the seven, don't write it.

**AI's constants are plausible hallucinations.** Ask AI "what timeout should I use here" and it may output `TIMEOUT = 30` — the 30 came from some training example, not from your environment. If the rule requires constant rationale, `TIMEOUT = 30  # AI-suggested, not yet tested in prod` is the comment that saves someone from blindly trusting it.

**AI has no "I got burned by this" memory.** You spend two hours debugging a subtle issue, and AI helps write the fix — but AI doesn't know about your two hours of pain. If the fix isn't annotated as a lesson-learned comment, the next refactor may delete that hard-won fix as "redundant code", and the bug returns.

**AI triggers "Why not X" at maximum frequency.** AI picks solutions based on statistical frequency, not project-specific constraints. It may pick 10 different JSON parsing approaches across 10 projects — each individually reasonable, collectively disastrous in one codebase. When you deliberately reject AI's suggested "standard approach", you MUST comment why, or the next session will "fix" it back.
