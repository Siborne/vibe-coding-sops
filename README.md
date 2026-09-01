# vibe-coding-sops

<p align="center">
  <img src="assets/readmeBannerImage.png" alt="vibe-coding-sops banner" width="800">
</p>

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
- Meaningful Comments: rules/code-quality/meaningful-comments.md
- Uncertainty Marking: rules/code-quality/uncertainty-marking.md
- Code Style Declaration: rules/code-quality/code-style-declaration.md
- Commit Messages: rules/workflow/commit-message.md
- Code Review: rules/workflow/code-review.md
- Branch & PR Workflow: rules/workflow/branch-pr-workflow.md
- Code Change Log: rules/documentation/code-change-log.md
- README Structure: rules/documentation/readme-structure.md
- Status Honesty: rules/communication/status-honesty.md
```

## Rule Index

Rules are organized into four categories.

### Code Quality [code-quality]
Rules that shape how code is written and protected against hidden uncertainty.

| Rule | Description |
|------|-------------|
| [Meaningful Comments](rules/code-quality/meaningful-comments.md) | Seven comment types worth writing: TODO, references, correctness, lessons learned, constants, load-bearing details, why-not-X |
| [Uncertainty Marking](rules/code-quality/uncertainty-marking.md) | Mark uncertain code with [NEEDS VERIFICATION] or [ASSUMPTION]; blocks DONE status |
| [Code Style Declaration](rules/code-quality/code-style-declaration.md) | Declare style guide, preferences, and forbidden patterns before writing any code |

### Workflow [workflow]
Rules about how changes flow through commits, review, and branches.

| Rule | Description |
|------|-------------|
| [Commit Messages](rules/workflow/commit-message.md) | Commits answer: what problem, alternatives considered, tradeoffs, surprises |
| [Code Review](rules/workflow/code-review.md) | Seven review principles: review code not people, actionable suggestions, ask don't command, explain why, label blocking vs suggestion, praise good work, know when to stop |
| [Branch & PR Workflow](rules/workflow/branch-pr-workflow.md) | Branch naming, PR scope, rebase sync, pre-merge checklist, reviewer merge + cleanup |

### Documentation [documentation]
Rules about the artifacts shipping alongside code.

| Rule | Description |
|------|-------------|
| [Code Change Log](rules/documentation/code-change-log.md) | Every change creates a structured log with root cause analysis + before/after |
| [README Structure](rules/documentation/readme-structure.md) | Funnel order: what → why care → how to use → how to install |

### Communication [communication]
Rules about how the AI reports status truthfully.

| Rule | Description |
|------|-------------|
| [Status Honesty](rules/communication/status-honesty.md) | Every AI reply must include a status block: DONE / PENDING VERIFICATION / BLOCKED / PARTIAL; DONE requires verification checklist |

See [rationale/](rationale/) for the "why" behind each rule.

## Skills

Skills are organized into three categories.

### Engineering
Fixed-process skills that execute a defined workflow step by step.

| Skill | Description |
|-------|-------------|
| [GitHub PR Workflow](skills/engineering/git-collaboration/github-pr-workflow/SKILL.md) | Enterprise Fork + Feature Branch + PR collaboration workflow — never commit to `main` directly |

### Conversational
Dialogue-driven skills that clarify information through conversation before producing output.

| Skill | Description |
|-------|-------------|
| [Prompt Composer](skills/conversational/requirement/prompt-composer/SKILL.md) | Turn vague requirements into multi-step dialogue scripts — Ask window designs prompts, Agent window executes |
| [Resume Builder](skills/conversational/interview/resume-builder/SKILL.md) | Conversational interview + project code scan to generate role-tailored STAR resume sections |

### Atomic
Single-purpose, independently callable technique units.

| Skill | Description |
|-------|-------------|
| [Agent Prompt Engineering](skills/atomic/agent-prompt-engineering/SKILL.md) | 5 engineering techniques for writing production Agent prompts — CoT, structured templates, examples, divide & conquer, data structure conversion |

See [skills/](skills/) for the full category tree and planned subcategories (engineering: git-collaboration · code-quality · testing · delivery; conversational: requirement · interview · brainstorm).

## Repository Structure

```
vibe-coding-sops/
├── rules/               # Rule files (what to do, how to do it), grouped into 4 categories
│   ├── code-quality/    #   meaningful-comments, uncertainty-marking, code-style-declaration
│   ├── workflow/        #   commit-message, code-review, branch-pr-workflow
│   ├── documentation/   #   code-change-log, readme-structure
│   └── communication/   #   status-honesty
├── rationale/           # Rationale files (why each rule exists)
│   ├── rules/           #   mirrors rules/: <category>/<en|zh>/<name>.md
│   └── skills/          #   mirrors skills/: <category>/<subcategory>/<name>/<en|zh>.md
├── skills/              # Reusable AI skills, grouped into 3 categories
│   ├── engineering/     #   fixed-process skills (git-collaboration, code-quality, testing, delivery)
│   ├── conversational/  #   dialogue-driven skills (requirement, interview, brainstorm)
│   └── atomic/          #   single-purpose technique units
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
