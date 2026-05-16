# Code Review Rule

**Rule:** Code review is for everyone — not just senior engineers. Review code, not people. Offer actionable suggestions. Ask, don't command.

## The Seven Principles

### 1. Review the code, not the person

- BAD: "Your code is hard to read"
- GOOD: "This function took me a couple reads to follow"

### 2. Prefer actionable suggestions

- BAD: "Don't use global variables"
- GOOD: "Could this be a config dataclass instead of a global?"

### 3. Ask rather than command

Questions spark discussion; commands shut it down.

- BAD: "Handle the null case"
- GOOD: "What happens if X is null here?"

### 4. Explain WHY

Every suggestion MUST include the reasoning behind it.

- BAD: "Use a constant here"
- GOOD: "Use a constant here so the timeout can be tuned per environment"

### 5. Distinguish blocking from suggestions

Label each comment so the author knows what MUST change vs. what's optional:

- `[blocking]` — MUST be addressed before merge
- `[suggestion]` — worth considering, author's call
- `[nit]` — trivial, feel free to ignore

### 6. Praise good work

Call out clever solutions and clean implementations. It tells the author what patterns to keep using.

```
The error recovery logic here is really clean, especially the retry
backoff strategy. Let's use this as the reference pattern for similar
external calls going forward.
```

### 7. Know when to stop

Contributor time and energy are finite. Focus on the big things (correctness, security, performance, maintainability). Small issues can be cleaned up later.
