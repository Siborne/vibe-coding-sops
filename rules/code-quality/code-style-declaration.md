---
name: code-style-declaration
title: Code Style Declaration
type: rule
category: code-quality
summary: 写任何代码之前必须声明项目的代码风格与约定：风格基准、决策偏好、禁止项，不允许无声明就开始写代码。
translation: zh
applies_to: 所有新项目在首行代码之前；存量项目在首次修改时补充进 CLAUDE.md
---
# Code Style Declaration Rule

**Rule:** Before writing ANY code, you MUST declare the project's code style and conventions. Starting without a style declaration is not allowed.

## Required Declarations

### 1. Style Baseline

Which public style guide does the project follow:

- Java: Google Java Style / Alibaba Java Coding Guidelines / Sun Code Conventions
- JavaScript/TypeScript: Airbnb / StandardJS / Prettier default / team custom
- Python: PEP 8 / Black / Google Python Style
- Go: Effective Go / Go Code Review Comments
- Other languages: cite the reference standard

### 2. Preference Decisions

Take a stance on common disagreements:

- **Branching**: if-else vs. strategy pattern vs. switch — at what complexity threshold?
- **Function length**: max lines? How to split when exceeded?
- **State management**: immutability-first (val/final) or mutable-by-default?
- **Error handling**: exceptions vs. Result type vs. return codes — pick one
- **Comment style**: JSDoc/JavaDoc scope — all public methods, or only non-obvious ones?

### 3. Forbidden Patterns

List patterns explicitly banned in this project:

- MUST NOT silently swallow exceptions (`catch (Exception e) {}`)
- MUST NOT use `System.out.println` instead of logging
- MUST NOT use Lombok `@Data` (over-generates getters/setters)

## Where to Record

Write the style declaration in the project's `CLAUDE.md`:

```markdown
## Code Style

- **Style guide**: Google Java Style
- **Branch logic**: if-else for ≤3 branches; strategy pattern for 4+
- **Function length**: ≤40 lines
- **State**: val/final preferred, mutable only with explicit reason
- **Error handling**: exceptions for unrecoverable, Result<T> for business errors
- **Comments**: JavaDoc on all public methods
- **Forbidden**: `.*` imports, wildcard generics, raw types
```

## Scope

All new projects before first code. Existing projects: add the declaration on first modification if CLAUDE.md doesn't already include it.
