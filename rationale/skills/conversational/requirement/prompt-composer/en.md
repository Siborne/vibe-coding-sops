# Why Prompt Composer Matters

## Trigger Scenario

A user wants to build an auth system and opens an Agent window, typing: "help me implement login, registration, password reset, OAuth integration." The Agent starts coding. After 500 lines, the direction is wrong — the user wanted JWT, the Agent used sessions; the user wanted GitHub OAuth, the Agent implemented Google. Fixing it inline takes 20 rounds of back-and-forth just to barely align.

Same requirement, different approach: another user uses two windows. First, in the Ask window, they break the requirement into 4 prompt steps. Then they paste each step into the Agent window one at a time. Each step's output is confirmed correct before moving to the next. Six rounds total, zero directional rework.

## Core Problem

In a single Agent window, the user's requirement description is typically vague, fragmented, and incomplete. The Agent defaults to "act first, clarify later," guessing the user's intent when information is insufficient. The result: code is written fast, but wrong faster.

Separating "clarify requirements" and "execute requirements" into two phases is fundamentally about decoupling **analysis** from **implementation**. Phase one does one thing — figure out exactly what to build. Phase two does one thing — execute clear instructions.

## Why This Must Be a Skill, Not Just User Discipline

**Users won't split automatically.** Most users open an Agent window, start describing requirements, the Agent starts coding, and the rhythm is already set. No one mid-stream says "wait, let's write the prompts properly first." The skill provides this split with a clear entry point and a fixed process.

**Splitting requires methodology.** When users split tasks themselves, the typical approach is "step one, do X; step two, do Y" — one sentence each. But a good prompt needs context, input/output definitions, and constraints. The skill hardens this writing method so it doesn't depend on the user's prompt engineering experience.

**Ask mode is naturally suited for this.** Ask mode doesn't write code, only converses — which is exactly the best environment for clarifying requirements. Ask mode has no "act first" inertia; the AI will probe, revisit, and reconfirm.

## Why the Output Format Is a "Conversation Script," Not a Document

- **One thing at a time**: Giving all steps at once, the Agent skips or overlooks steps. Broken into individual steps, each has a clear start and end
- **Recoverable after interruption**: If Step 2 goes wrong, no need to redo Step 1. Confirming each step's output is correct lays the foundation for the next
- **Role definition comes first**: The execution window AI reads the role before the task — more effective than "you are an X" in the first line of a prompt, because the role defines behavior boundaries for the entire session, not just a single instruction

## Consequences Without This Skill

- Complex tasks repeatedly fail in a single Agent window; users blame "AI capability" when the real issue is prompt clarity
- Users spend significant time clarifying requirements inside the Agent window — which is designed for execution, not clarification
- Each user invents their own prompt-writing method, with no reusability across the team
- Good prompt techniques remain at the "tribal knowledge" level, impossible to replicate for others
