# Why Code Review

## The Trigger

A developer spends two weeks building a feature and merges directly to main. A week later, production breaks. No one knows how that logic works because only the author ever read it. Worse: three other modules use the same pattern, but each implemented it differently — everyone wrote their own version.

## The Core Insight: Four Values of Review

### 1. Knowledge Distribution

Unreviewed code = the author is the sole expert. When the author is on vacation, leaves the company, or simply forgets — the code becomes a black box. Review ensures at least two people understand every line.

### 2. Hidden Assumptions Exposed

Newcomers and developers from different domains ask "why is this done this way?" These questions expose assumptions that were never documented or simplified. Authors develop blind spots from prolonged exposure to the codebase ("this goes without saying"). An outside perspective breaks through them.

### 3. Pattern Convergence

Without review, everyone writes in their own style. Three weeks later, the same feature has three implementations. Review catches this: "we discussed this pattern before — let's use approach X consistently." The codebase converges instead of diverging.

### 4. Accelerated Learning

Review exposes everyone to different corners of the codebase and different problem-solving approaches. For vibe coding specifically, review is also the checkpoint for catching suboptimal patterns in AI-generated code.

## AI-Specific Risk

AI generates code far faster than humans can review it. This creates an asymmetry: 200 lines of code in 30 seconds from AI, but 20 minutes to review it properly. Without review discipline, generation speed overwhelms review capacity.

**AI bugs live in different places than human bugs.** Humans err in complex logic. AI errs in edge cases, concurrency safety, resource cleanup, and error-handling paths — low-frequency patterns in training data. Worse, AI code works on the happy path, creating a false sense of security that lowers review vigilance.

**AI produces divergent styles across sessions.** This is why the review rule emphasizes pattern convergence. Without review, AI implements the same feature three different ways across three sessions — because each invocation samples from a different region of its style distribution. Review is the mechanism that re-converges these divergences.

**AI amplifies the knowledge distribution problem.** A human author at least has ownership and memory of their code. With AI assistance, you're the prompt author but not the code author — you may not fully understand every line AI generated, nor remember why it chose a particular implementation. If that code merges unreviewed, it's a double black box: even the "author" doesn't fully understand it.
