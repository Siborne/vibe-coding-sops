# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`vibe-coding-sops` stores rules for AI-assisted coding (vibe coding). Each rule defines what to do and how (`rules/`), paired with a rationale explaining why (`rationale/`).

**When this repo is loaded into your project's context, you must follow all rules in `rules/`.**

## Repository Structure

```
rules/               # Rule files — what to do, how to do it, grouped into 4 categories
  code-quality/      #   meaningful-comments, uncertainty-marking, code-style-declaration
  workflow/          #   commit-message, code-review, branch-pr-workflow
  documentation/     #   code-change-log, readme-structure
  communication/     #   status-honesty
rationale/rules/     # Rule rationale — mirrors rules/: <category>/<en|zh>/<name>.md
rationale/skills/    # Skill rationale — mirrors skills/: <category>/<subcategory>/<name>/<en|zh>.md
skills/              # Reusable AI skills, grouped into 3 categories
  engineering/       #   fixed-process skills
  conversational/    #   dialogue-driven skills
  atomic/            #   single-purpose technique units
README.md            # Rule & skill index with badges and quick-start guide
LICENSE              # MIT
```

## Rules to Load

### Code Quality
| Rule | File | Core Requirement |
|------|------|-----------------|
| Meaningful Comments | `rules/code-quality/meaningful-comments.md` | Comments MUST explain WHY, not WHAT. Seven types: TODO, references, correctness justification, lessons learned, magic constant rationale, load-bearing details, "why not X" |
| Uncertainty Marking | `rules/code-quality/uncertainty-marking.md` | Tag uncertain code with [NEEDS VERIFICATION] or [ASSUMPTION: ...]; integrates with Status Honesty via Uncertain field; DONE blocked while tags exist |
| Code Style Declaration | `rules/code-quality/code-style-declaration.md` | Before ANY code, MUST declare: style baseline, preference decisions (if-else vs strategy, immutability), forbidden patterns |

### Workflow
| Rule | File | Core Requirement |
|------|------|-----------------|
| Commit Messages | `rules/workflow/commit-message.md` | Commit body MUST answer: what problem forced this change, alternatives considered, trade-offs, surprises |
| Code Review | `rules/workflow/code-review.md` | Review code not people. Offer actionable suggestions. Ask, don't command. Distinguish blocking from suggestion. Know when to stop |
| Branch & PR Workflow | `rules/workflow/branch-pr-workflow.md` | Full lifecycle: branch naming (feat/fix/refactor/docs/chore/test), PR scope (semantic completeness), rebase-first sync, 3-layer pre-merge checklist, reviewer merge + cleanup |

### Documentation
| Rule | File | Core Requirement |
|------|------|-----------------|
| Code Change Log | `rules/documentation/code-change-log.md` | After every Edit/Write, create a change log in `docs/变更记录/` with root cause analysis and before/after code |
| README Structure | `rules/documentation/readme-structure.md` | READMEs MUST follow funnel order: what → why care → how to use → how to install. Show usage before installation |

### Communication
| Rule | File | Core Requirement |
|------|------|-----------------|
| Status Honesty | `rules/communication/status-honesty.md` | After every code change, report one of four statuses (DONE/PENDING VERIFICATION/BLOCKED/PARTIAL); DONE requires verification checklist |

## Skills to Load

### Engineering
| Skill | File | Core Capability |
|-------|------|----------------|
| GitHub PR Workflow | `skills/engineering/git-collaboration/github-pr-workflow/SKILL.md` | Enterprise Fork + Feature Branch + PR workflow — never commit to `main` directly |

### Conversational
| Skill | File | Core Capability |
|-------|------|----------------|
| Prompt Composer | `skills/conversational/requirement/prompt-composer/SKILL.md` | Turn vague requirements into multi-step dialogue scripts — Ask window clarifies, Agent window executes |
| Resume Builder | `skills/conversational/interview/resume-builder/SKILL.md` | Conversational interview + project code scan to generate role-tailored STAR resume sections |

### Atomic
| Skill | File | Core Capability |
|-------|------|----------------|
| Agent Prompt Engineering | `skills/atomic/agent-prompt-engineering/SKILL.md` | 5 techniques for writing production Agent prompts: CoT, structured templates, positive/negative examples, divide & conquer, data structure conversion |

## Adding a New Rule

1. Choose the category (`code-quality` | `workflow` | `documentation` | `communication`) and create `rules/<category>/<slug>.md` — rule description + examples (no rationale in the rule file), with YAML frontmatter (`name`/`title`/`type`/`category`/`summary`/`translation`/`applies_to`)
2. Create `rationale/rules/<category>/en/<slug>.md` and `rationale/rules/<category>/zh/<slug>.md` — motivation, context, consequences
3. Add to README.md (and README.zh.md) index table under the right category
4. Add to the Rules to Load table in this CLAUDE.md
5. Re-run `scripts/generate-stats.sh` and commit `stats.json`

## Adding a New Skill

1. Choose the category + subcategory (engineering: git-collaboration · code-quality · testing · delivery; conversational: requirement · interview · brainstorm; atomic: none) and create `skills/<category>/<subcategory>/<slug>/SKILL.md` — skill definition with techniques, examples, and selection guide, with YAML frontmatter (`name`/`title`/`description`/`type`/`category`/`subcategory`/`triggers`/`tags`)
2. Create `rationale/skills/<category>/<subcategory>/<slug>/zh.md` — Chinese rationale: trigger scenario, core problem, consequences
3. Create `rationale/skills/<category>/<subcategory>/<slug>/en.md` — English rationale, same structure
4. Add to README.md (and README.zh.md) Skills table under the right category
5. Add to the Skills to Load table in this CLAUDE.md
6. Re-run `scripts/generate-stats.sh` and commit `stats.json`

## Self-Application: This Repo's Own Change Log

This repo's rules apply to Claude Code when editing THIS repo. Specifically:

**Every time you modify files in this repo, create a change log in `docs/变更记录/`.**

Naming: `<brief-description>_<YYYY-MM-DD>.md`

The change log must include:
- **What** was changed (files, sections)
- **Why** the change was made (user request, rule clarification, fix)
- **Before/After** if the change is a rewrite or structural change

This ensures the evolution of the rules themselves is traceable — the meta-rule applies to its own home.
