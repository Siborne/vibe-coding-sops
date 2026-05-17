# Resume Builder Skill — Design Spec

**Date:** 2026-05-17
**Status:** Approved
**Topic:** New skill — scan project code + user info to generate role-tailored resume project experience

## Overview

Writing project experience for a resume is tedious: extract business context from README, compile tech stack from dependency files, recall what you personally did, and express it in STAR format. This skill automates the process via a conversational interview → project scan → tailored output pipeline, producing resume-ready content for a single project.

## Skill Design

### 1. Four-Phase Workflow

**Phase 1 — Info Collection (one question at a time, required first):**

| Order | Item | Required | Purpose |
|-------|------|----------|---------|
| 1 | Target role direction | Yes | Backend / Frontend / Full-end / Full-stack / Data Engineering / DevOps / Other |
| 2 | Target language | Yes | Chinese (中文) or English |
| 3 | Project path | Yes | Which directory to scan |
| 4 | Personal role | No | Lead / Core developer / Contributor / Intern |
| 5 | Duration | No | e.g. 2024.03–2025.01 |
| 6 | Company/org name | No | To display on resume |
| 7 | Known metrics | No | User-provided data (QPS, user count, etc.); AI infers or marks `[需补充数据]` otherwise |
| 8 | Tech stack include/exclude | No | Emphasize or hide specific technologies |
| 9 | Emphasis preference | No | Business-focused vs. technical-depth-focused |

Each optional question includes a "skip" affordance. After collection, summarize what was gathered and confirm before scanning.

**Phase 2 — Project Scanning:**

Browse and extract from:
- `README.md` / project homepage → business description, project name
- `package.json` / `pyproject.toml` / `Cargo.toml` / `go.mod` etc. → tech stack
- Directory structure → project type inference (Web/Mobile/CLI/Data pipeline/etc.)
- `git log` (author-filtered if git user name available) → personal contributions, commit frequency
- Core modules / routes / API definitions → technical complexity signals

**Phase 3 — Resume Generation:**

Apply role-direction weightings (see §2 below) to produce:
1. **Project Name** — from README or directory name
2. **Project Summary** — 2–4 sentences: what, who it serves, core value/scale
3. **Tech Stack** — tags grouped logically (framework → language → infra)
4. **Key Contributions** — 3–5 STAR items: **S**ituation → **A**ction → **R**esult
5. **Project Impact** — one-line summary

**Phase 4 — Output & Refinement:**

Output the full resume section, then prompt:
> "以上是生成的简历项目经历。哪个点需要改？可以具体说'第3条STAR改成我负责的XX模块'或'技术栈加上XX'。"

### 2. Role-Direction Weighting

Different roles emphasize different aspects of the same codebase:

| Role | Summary Focus | STAR Preference | Tech Highlight |
|------|--------------|-----------------|----------------|
| Backend | Business logic, API design, DB, concurrency | High-concurrency, transactions, caching, middleware | Spring Boot / Go / PostgreSQL / Redis / Kafka |
| Frontend | User interaction, component architecture, state, perf | Component encapsulation, perf optimization, compatibility, tooling | React / Vue / TypeScript / Webpack / Vite |
| Full-end | Requirements + one dominant end (usually backend) | End-to-end closure, API contracts, cross-end collaboration | Both ends, emphasize dominant side |
| Full-stack | System overview, front-back collaboration, deployment | Architecture decisions, full-chain debugging, DevOps | Breadth: frontend + backend + infra |
| Data Engineering | Data pipelines, warehouse modeling, metrics system | ETL, data warehouse modeling, governance, scheduling | Spark / Flink / dbt / Hive / Airflow |
| DevOps | Infrastructure, CI/CD, monitoring, containers | Automation, stability, cost optimization, security | Docker / K8s / Terraform / Jenkins / Prometheus |

**Universal rules:**
- Every STAR item covers S (context) → A (action taken) → R (quantified result). Mark `[需补充数据]` when metrics are unavailable.
- Tech stack only lists what the project actually uses. No fabrication.
- Verb choice reflects role level: "Led/Architected" for leads, "Developed/Contributed to" for contributors.

### 3. Output Templates

**Chinese:**
```
## [项目名称]

**[公司名]** | [时间段] | 角色: [个人角色]

**项目简介:** [2-4句话]

**技术栈:** `React` `TypeScript` `Node.js` `PostgreSQL`

**主要职责:**
- **背景:** [问题/痛点]
  **行动:** [通过xx方法/技术，设计/实现xx]
  **结果:** [效果 + 数据]

**项目成果:** [一句话交付总结]
```

**English:**
```
## [Project Name]

**[Company]** | [Duration] | Role: [Your Role]

**Summary:** [2-4 sentences]

**Tech Stack:** `React` `TypeScript` `Node.js` `PostgreSQL`

**Key Contributions:**
- **Situation:** [Problem/context]
  **Action:** [What you did]
  **Result:** [Outcome + metrics]

**Impact:** [One-line delivery summary]
```

### 4. Scope and Boundaries

**Applies to:**
- Any local project directory with code and a README
- Single-project focus per invocation

**Does NOT handle:**
- Multiple project directories in one run (user can invoke twice)
- Resume sections beyond project experience (e.g., education, skills summary)
- Formatting for specific platforms (LaTeX, Word, etc.) — output is markdown

**Edge cases:**

| Scenario | Behavior |
|----------|----------|
| No README found | Infer project info from directory structure + package files; flag "no README — info is inferred" |
| No git history | Skip git-based contribution analysis; rely on user input for personal role |
| Very large mono-repo | Ask user which sub-module to focus on |
| Missing metrics everywhere | Generate STAR without numbers; append `[需补充数据]` to each result line |
| User skips all optional info | Work with role + language + path only; mark clearly what was inferred vs. provided |

## Implementation Plan (Next)

1. Create `skills/resume-builder.md` — the skill file
2. Create `rationale/skills/en/resume-builder.md` — English rationale
3. Create `rationale/skills/zh/resume-builder.md` — Chinese rationale
4. Update `README.md` — add to Skills table
5. Update `CLAUDE.md` — mention the skill
6. Run `scripts/generate-stats.sh` to refresh badge counts
