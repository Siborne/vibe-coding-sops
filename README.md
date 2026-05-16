# vibe-coding-sops

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/Siborne/vibe-coding-sops/main/stats.json&query=%24.rules&label=rules&color=4caf50" alt="Rules">
  <img src="https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/Siborne/vibe-coding-sops/main/stats.json&query=%24.rationale&label=rationale&color=2196f3" alt="Rationale">
  <img src="https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/Siborne/vibe-coding-sops/main/stats.json&query=%24.skills&label=skills&color=ff9800" alt="Skills">
  <img src="https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/Siborne/vibe-coding-sops/main/stats.json&query=%24.changelogs&label=changelogs&color=9e9e9e" alt="Changelogs">
  <img src="https://img.shields.io/badge/status-active-success.svg" alt="Status: Active">
</p>

> A rule collection for AI-assisted coding (vibe coding). Each rule defines what to do and how; each rationale explains why. [中文版](README.zh.md)

## Why You Need This

AI-assisted coding is fast, but speed ≠ quality. Without constraints, vibe coding leads to:

- Code gets changed — you don't know what changed (no change log)
- `git blame` three months later returns "fix bug" with zero context
- AI-generated code looks correct but hides edge-case issues
- Team code style diverges into three variants within days

This repo writes down the rules and rationales for vibe coding, loaded into Claude Code's project memory, so every AI-assisted session runs under the same constraints.

## Quick Start

Clone this repo and reference the rules in your project's CLAUDE.md:

```
# In your project's CLAUDE.md:
This project follows vibe-coding-sops rules, see:
- Code Change Log: rules/code-change-log.md
- Meaningful Comments: rules/meaningful-comments.md
- README Structure: rules/readme-structure.md
- Commit Messages: rules/commit-message.md
- Code Review: rules/code-review.md
- Code Style Declaration: rules/code-style-declaration.md
- Branch & PR Workflow: rules/branch-pr-workflow.md
- Status Honesty: rules/status-honesty.md
- Uncertainty Marking: rules/uncertainty-marking.md
```

## Rule Index

| # | Rule | Description |
|---|------|-------------|
| 1 | [Code Change Log](rules/code-change-log.md) | Every change creates a structured log with root cause analysis + before/after |
| 2 | [Meaningful Comments](rules/meaningful-comments.md) | Seven comment types worth writing: TODO, references, correctness, lessons learned, constants, load-bearing details, why-not-X |
| 3 | [README Structure](rules/readme-structure.md) | Funnel order: what → why care → how to use → how to install |
| 4 | [Commit Messages](rules/commit-message.md) | Commits answer: what problem, alternatives considered, tradeoffs, surprises |
| 5 | [Code Review](rules/code-review.md) | Seven review principles: review code not people, actionable suggestions, ask don't command, explain why, label blocking vs suggestion, praise good work, know when to stop |
| 6 | [Code Style Declaration](rules/code-style-declaration.md) | Declare style guide, preferences, and forbidden patterns before writing any code |
| 7 | [Branch & PR Workflow](rules/branch-pr-workflow.md) | Branch naming, PR scope, rebase sync, pre-merge checklist, reviewer merge + cleanup |
| 8 | [Status Honesty](rules/status-honesty.md) | Every AI reply must include a status block: DONE / PENDING VERIFICATION / BLOCKED / PARTIAL; DONE requires verification checklist |
| 9 | [Uncertainty Marking](rules/uncertainty-marking.md) | Mark uncertain code with [NEEDS VERIFICATION] or [ASSUMPTION]; blocks DONE status |

See [rationale/](rationale/) for the "why" behind each rule.

## Skills

| Skill | Description |
|-------|-------------|
| [Prompt Composer](skills/prompt-composer.md) | Turn vague requirements into multi-step dialogue scripts — Ask window designs prompts, Agent window executes |

## Repository Structure

```
vibe-coding-sops/
├── rules/               # Rule files (what to do, how to do it)
│   └── ...              # 9 rules
├── rationale/           # Rationale files (why each rule exists)
│   └── ...
├── skills/              # Reusable AI skills
│   └── ...
├── docs/
│   ├── superpowers/
│   │   ├── plans/       # Implementation plans
│   │   └── specs/       # Design specs
│   └── 变更记录/         # Code change logs
├── scripts/             # Helper scripts
│   └── generate-stats.sh
├── stats.json           # Project statistics (powers the badges above)
├── CLAUDE.md            # Project memory for Claude Code
├── LICENSE
├── README.md            # This file (English)
└── README.zh.md         # Chinese version
```

## License

MIT © 2026 Siborne
