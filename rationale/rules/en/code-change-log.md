# Why Code Change Logs

## The Trigger

You inherit a project last touched six months ago. Production is down. You open git log. The commits say "fix", "update", "change stuff". You have no idea what was changed, why, or which "fix" might have caused the current outage. You spend hours reverse-engineering context that someone once had but never wrote down.

This is the cost of no change log.

## The Core Insight

Code changes are decisions frozen in time. A diff shows WHAT moved. A commit message shows WHY the change was made (at the feature level). But neither captures:

- The root cause that led to this specific fix
- The before/after code comparison with rationale per changed block
- Which changes were deliberate fixes vs. incidental side effects

A structured change log fills this gap. It makes the decision-making process visible.

## AI-Specific Risk

AI-assisted coding amplifies this problem in three ways:

**Silent collateral changes.** When you ask AI to "fix this bug", it may adjust three related files — but only tell you about the bug fix. Those collateral changes might be correct cleanup, or they might be misunderstandings of adjacent logic. Without a change log, you can't distinguish them two weeks later. The git diff will show four changed blocks with no indication that only one was the actual fix.

**No author memory to fall back on.** Hand-written code comes with implicit memory: you remember roughly what you changed and why, because you held the reasoning in your head. With AI-assisted coding, you're a reviewer, not the author. You didn't hold every line in working memory as it was written. The structured change log replaces the author memory you never had.

**Invisible prompt iteration.** A feature may go through 5 prompt iterations and 3 abandoned approaches before settling. If the final approach's rationale isn't recorded, the next person will wonder "why not use the simpler X approach", spend half a day trying X, discover it doesn't work — and this exact lesson was learned three months ago and lost because nobody wrote it down.

In short: for hand-written code, change logs are nice to have. For AI-assisted coding, they're the only thread connecting code to context.

## Consequences Without This Rule

- The same bug gets fixed and re-introduced in cycles
- Refactoring destroys historical fixes because nobody knows that weird-looking `if` was load-bearing
- Production incidents are debugged via `git blame` + guessing
