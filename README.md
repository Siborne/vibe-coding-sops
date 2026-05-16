# vibe-coding-sops

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/rules-7-4caf50.svg" alt="Rules: 7">
  <img src="https://img.shields.io/badge/status-active-success.svg" alt="Status: Active">
  <img src="https://img.shields.io/badge/vibe%20coding-essential-f39f37.svg" alt="Vibe Coding: Essential">
  <img src="https://img.shields.io/badge/lang-en--CN-lightgrey.svg" alt="Language: EN/CN">
</p>

> A collection of rules for AI-assisted coding (vibe coding). Each rule defines what to do and how. Each rationale explains why.
>
> AI 辅助编程（vibe coding）规则集合。规则以英文为主（AI 执行），理由中英双语（人阅读）。

## Why You Need This

AI-assisted coding is fast, but speed isn't quality. Without rule constraints, vibe coding leads to:

- Code changed — but nobody knows what changed (no change log)
- `git blame` returns "fix bug" three months later — zero information
- AI-generated code looks correct but hides edge-case problems
- Three coding styles appear in the same project within three days

This repo writes down the **rules** and **rationale** that vibe coding MUST follow, loaded into Claude Code's project memory to ensure every AI-assisted coding session runs under the same constraints.

> 中文用户请查看 [rationale/zh/](rationale/zh/) 目录获取中文版理由说明。

## Quick Start

Clone this repo and reference the rules in your project's CLAUDE.md:

```
# In your project's CLAUDE.md:
This project follows the rules in vibe-coding-sops. See:
- Code Change Log: rules/code-change-log.md
- Meaningful Comments: rules/meaningful-comments.md
- README Structure: rules/readme-structure.md
- Commit Messages: rules/commit-message.md
- Code Review: rules/code-review.md
- Code Style Declaration: rules/code-style-declaration.md
- Branch & PR Workflow: rules/branch-pr-workflow.md
```

## Rule Index

| # | Rule | Description |
|---|------|-------------|
| 1 | [Code Change Log](rules/code-change-log.md) | After every code change, create a structured change log with root cause analysis + before/after code |
| 2 | [Meaningful Comments](rules/meaningful-comments.md) | Comments explain WHY, not WHAT. Seven types: TODO, references, correctness, lessons learned, magic constants, load-bearing details, "why not X" |
| 3 | [README Structure](rules/readme-structure.md) | Funnel organization: what → why care → how to use → how to install. Usage before installation |
| 4 | [Commit Messages](rules/commit-message.md) | Commit body answers: what problem, alternatives considered, tradeoffs, surprises |
| 5 | [Code Review](rules/code-review.md) | Seven principles: review code not people, actionable suggestions, ask don't command, explain why, label blocking vs suggestion, praise good work, know when to stop |
| 6 | [Code Style Declaration](rules/code-style-declaration.md) | Before any code, declare style baseline, preference decisions, forbidden patterns |
| 7 | [Branch & PR Workflow](rules/branch-pr-workflow.md) | Full lifecycle: branch naming (feat/fix/refactor/docs/chore/test), PR scope (semantic completeness), rebase-first sync, 3-layer pre-merge checklist, reviewer merge + cleanup |

Each rule's rationale (WHY) is in [rationale/](rationale/) (English) and [rationale/zh/](rationale/zh/) (Chinese).

## Repository Structure

```
vibe-coding-sops/
├── rules/           # Rule files — what to do, how to do it (English)
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   ├── code-review.md
│   ├── code-style-declaration.md
│   └── branch-pr-workflow.md
├── rationale/       # Rationale files — why the rule exists (English)
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   ├── code-review.md
│   ├── code-style-declaration.md
│   ├── branch-pr-workflow.md
│   └── zh/          # Rationale files (Chinese reference)
│       ├── code-change-log.md
│       ├── meaningful-comments.md
│       ├── readme-structure.md
│       ├── commit-message.md
│       ├── code-review.md
│       └── code-style-declaration.md
├── docs/
│   └── 变更记录/
├── CLAUDE.md
├── LICENSE
└── README.md
```

## License

MIT © 2026 Siborne
