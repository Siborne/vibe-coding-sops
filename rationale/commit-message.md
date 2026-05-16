# Why Complete Commit Messages

## The Trigger

You run `git blame` to understand why a line of code from three years ago exists. The commit message says "fix". No issue link, no problem description, no discussion of alternatives. Is that line still needed? Did the original bug go away? You don't know. You leave the line in place. Forever.

## The Core Insight: Commits Are Time Machines

Every code change corresponds to a decision moment. The context at that moment — the symptom, the alternatives considered, the trade-off reasoning — vanishes unless it's written into the commit message. Code evolves, but "why the code became this way" lives only in commit history.

Code tells you WHAT. Comments (at their best) tell you WHY locally — within a function or file. Commit messages tell you WHY globally — the motivation and context behind an entire change set.

## AI-Specific Risk

AI-assisted coding inflates commit frequency. What was 3-5 commits per day becomes 20-30. Higher frequency makes message quality more critical, not less.

**AI's default commit messages are useless.** If you let AI generate a commit message without giving it a template, it produces "fix bug", "update code", "refactor" — it has no memory of your change context and can only guess from the diff. You MUST give it the four-question template to produce something useful.

**Batch commits obscure individual decisions.** With AI, you might change 5 files across 3 features in 30 minutes and commit them together. If the commit message doesn't decompose each decision, `git blame` points to a giant mixed commit that explains nothing.

**WHY matters more than WHAT, and WHY is what AI can't provide.** AI can generate a perfect diff description — it can see which lines changed. But why option B over option A? Why avoid a seemingly better pattern? The AI doesn't know. Only you do. And these are precisely the details that are scarcest three months later during an incident.
