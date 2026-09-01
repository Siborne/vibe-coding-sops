# Why Code Style Declarations

## The Trigger

A new project starts. AI generates the first piece of code — Python, 4-space indent, type hints here and there, a mix of try-except and return-None for errors. The next day, AI generates another piece — 2-space indent, uses `raise` instead of `return None`. Three days in, four styles coexist in a single file.

## The Core Problem

AI training data covers every style. It's not on your team. Ask the same prompt twice and you may get code in two different styles. Without a declared style, AI randomly samples from every style it has ever seen — and a day's output can look like four different authors wrote it.

The style declaration is a global constraint. It turns "every response may have a different style" into "every response follows one standard."

## Why "Just Infer From Existing Code" Doesn't Work

- Existing code may already be inconsistent (written before the declaration existed)
- Some preferences are strategic (when to use the strategy pattern) — you can't infer them from code that only shows the current choice
- Forbidden patterns are invisible in code — you can see `catch (Exception e) {}` sitting there, but you can't see that it's forbidden

## AI-Specific Risk

Hand-written code has natural style consistency — one brain, one pair of hands. AI-assisted coding faces infinite virtual authors: each AI response may draw from a different region of its training distribution.

**Style randomness is systematic, not incidental.** This isn't a bug in a particular model — it's inherent to all LLMs. Training data covers all styles. Models learn all styles. Without constraints, they sample randomly. A 500-line file generated across 5 sessions can end up with 3 indentation styles, 2 error-handling patterns, and 4 naming conventions. The style declaration is the global lock on this randomness.

**Forbidden patterns must be explicit; AI won't infer them.** Your project bans Lombok `@Data`, but AI doesn't know that — it sees `@Getter` and `@Setter` in your code, infers "this project uses Lombok", and helpfully adds `@Data` in the next block. Forbidden patterns are the briefing you owe the AI: which common practices are off-limits here and why.

**Even with existing code, correct inference is impossible.** Style-guide-level decisions ("use strategy pattern when branches exceed 3") can't be reverse-engineered from code that only shows the current state. You see an if-else chain; you don't see the rule that says it should have been a strategy pattern. The style declaration fills this information gap before AI makes its first guess.
