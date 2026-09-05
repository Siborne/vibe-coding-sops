# Why Funnel-Structured READMEs

## The Trigger

You find a GitHub repo whose name matches what you need. You open the README. The first 50 lines are a dependency list, environment variables, and a Docker startup command. You scroll to the bottom and still don't know what the thing actually does. You close the tab and move on.

Most README readers stay for seconds, not minutes.

## The Core Insight: Funnel Psychology

A funnel structure matches a stranger's decision process:

1. **What does it do?** — The "matching" phase. One sentence + one image lets the reader decide: "Can this solve my problem?" If not, you've saved everyone's time.
2. **Why should I care?** — The "motivation" phase. So many similar tools exist. Why spend time on this one?
3. **How do I use it?** — The "fantasy" phase. Show the end result. Build desire: "I want this."
4. **How do I install it?** — The "action" phase. Installation steps only matter after the reader has decided to commit.

The reverse — the default in most mediocre READMEs — demands investment before establishing value. Most people won't invest.

## AI-Specific Risk

AI-assisted projects ship fast and iterate often — and the README is frequently forgotten because AI won't maintain it for you.

**AI's default README structure is anti-funnel.** Training data is full of READMEs that open with installation. When you say "write me a README", AI tends to generate Installation → Configuration → API — because that's what most READMEs in its training data look like. Unless you explicitly require funnel order, AI won't produce it. This rule locks in the correct structure so AI follows it.

**Code-README sync is a one-way disconnect.** AI adds a core feature and changes two API endpoints — it updates the code but doesn't proactively update the README. Three months later, the README describes features that no longer exist while omitting the ones that do. A correct-but-stale README is worse than no README: it actively misleads new users into following broken instructions.

**AI can't narrate.** AI can list every API endpoint exhaustively. It cannot judge "what does a new user need to see first?" The funnel's value is in the human-curated narrative order — you must tell AI what order to present information, rather than letting it dump an API reference.
