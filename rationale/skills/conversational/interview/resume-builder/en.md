# Why Resume Builder Matters

## Trigger Scenario

A developer needs to update their resume. Their project repo has 100+ commits spanning 8 months. They open a blank document and stare at it. What was the business context? What tech stack did we actually use? What did *I* specifically do? After 40 minutes of git-log archaeology and README re-reading, they have 3 bullet points — one of which is "Fixed bugs and improved performance."

Same developer, different approach: they invoke this skill. Six questions later (two required, four skipped), the AI scans the repo, extracts the tech stack, identifies their git contributions, and outputs a 5-STAR project section tailored to "Backend Developer." They refine two bullets in 3 minutes. Done.

## Core Problem

Resume writing has three pain points that a code-scanning skill can solve:

1. **Recall gap**: Developers don't remember everything they did over 6-12 months. Git history has the facts, but nobody reads 500 commit messages to write 5 bullets.
2. **Role framing**: The same project looks different to a frontend developer vs. a backend developer. Manual resume writing often defaults to a generic "worked on X project" description that sells neither role short nor strong — just generic.
3. **STAR discipline**: Most bullet points end up as "Responsible for X module" or "Used React and TypeScript" — activities, not accomplishments. STAR format (Situation → Action → Result) is well-known but hard to self-enforce.

## Why This Must Be a Skill, Not a Script

**Code scanning needs judgment.** A static script can grep for dependencies, but it can't read an API route file and recognize "this is a multi-tenant data isolation pattern worth highlighting in a resume." Only an LLM can inspect code and extract technically meaningful signals.

**Role adaptation is nuanced.** Frontend vs. backend emphasis isn't a simple filter — it's about reframing the same codebase through different lenses. A WebSocket connection is "real-time collaboration infrastructure" to a backend developer and "optimistic UI with server sync" to a frontend developer.

**Information collection must be conversational.** Users skip questions, change their minds, and realize mid-way they want a different role emphasis. A form-based approach can't adapt. A conversational agent can.

## Why STAR Format Is Non-Negotiable

- **Situation** answers "why did this matter" — context that a bullet like "Optimized PostgreSQL queries" lacks
- **Action** answers "what did *you* specifically do" — distinguishes personal contribution from team output
- **Result** answers "so what" — the difference between "wrote code" and "reduced P99 latency from 200ms to 45ms"

## Why Role-Specific Weighting

A full-stack developer's resume that lists 15 technologies with equal weight communicates "jack of all trades, master of none." The same developer applying for a backend role should emphasize backend depth and frame frontend work as "understands the full picture" rather than a co-equal skill. Role weighting gives the reader a clear signal about what the candidate is strongest at.

## Consequences Without This Skill

- Developers spend 30-60 minutes per project manually extracting and framing resume content
- Resume bullets default to activities ("worked on", "used", "responsible for") rather than accomplishments
- The same project across different role applications uses identical language, missing the chance to target the reader
- Quantified results are omitted not because they don't exist, but because the developer forgot to measure or recall them — the `[需补充数据]` marker at least makes the gap visible
