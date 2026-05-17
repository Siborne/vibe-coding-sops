# Resume Builder Skill — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a new `resume-builder` skill that scans project code + collects user information to generate role-tailored resume project experience in STAR format.

**Architecture:** One main skill file (`skills/resume-builder.md`) defining a 4-phase workflow: conversational info collection → project code scan → role-tailored generation → output + refinement. Bilingual rationale files follow the existing prompt-composer rationale pattern. README tables updated in both languages.

**Tech Stack:** Markdown only (skill + rationale files); bash script for stats regeneration.

---

### Task 1: Create the skill file

**Files:**
- Create: `skills/resume-builder.md`

- [ ] **Step 1: Write the skill file**

```markdown
# Resume Builder

把项目代码和用户信息转化为角色定制的简历项目经历。对话式访谈收集信息 → 扫描项目代码 → 按方向生成 STAR 简历段落。

## 何时使用

- 用户说"帮我写简历"、"把这个项目写成简历经历"、"根据项目生成简历"
- 用户需要针对特定方向（后端/前端/全栈/数据研发等）写项目经历
- 有本地项目目录可供扫描

触发关键词：简历、resume、CV、项目经历、project experience、STAR

## 工作流程

### Phase 1: 信息收集

一次只问一个问题。必填项先问，可选项末尾标注 `(可选，可跳过)`。

**问 1 — 目标方向（必填）：**

> 简历目标方向是什么？
> 
> A. 后端开发  B. 前端开发  C. 全端开发  D. 全栈开发  E. 数据研发  F. DevOps  G. 其他（请说明）

**问 2 — 简历语言（必填）：**

> 简历用什么语言？
> 
> A. 中文  B. 英文

**问 3 — 项目路径（必填）：**

> 要扫描的项目目录路径是什么？请提供绝对路径或相对于当前工作目录的路径。

**问 4 — 个人角色（可选）：**

> 你在这个项目中的角色是什么？（可选，可跳过）
> 
> A. 项目负责人/Lead  B. 核心开发/Core Developer  C. 参与者/Contributor  D. 实习生/Intern

**问 5 — 在职时间（可选）：**

> 在这个项目的时间段？（可选，可跳过）
> 
> 格式如：2024.03–2025.01

**问 6 — 公司/组织名（可选）：**

> 写在简历上的公司或组织名称？（可选，可跳过）

**问 7 — 已知量化数据（可选）：**

> 有没有你已经知道的量化数据？（可选，可跳过）
> 
> 例如：QPS、用户量、日活、收入影响、性能提升百分比、团队规模等。
> 如果有，请提供。如果没有，AI 会从代码推断或标注 [需补充数据]。

**问 8 — 技术栈补充/排除（可选）：**

> 有没有想额外强调或刻意隐藏的技术？（可选，可跳过）
> 
> 例如："重点突出 Kafka 和 Redis，不要提 jQuery" 或 "加上 GraphQL，虽然依赖里没写"

**问 9 — 侧重点（可选）：**

> 项目经历更侧重哪个方向？（可选，可跳过）
> 
> A. 偏业务价值（解决了什么业务问题）  B. 偏技术深度（架构设计、技术挑战）

**收集完毕后**，汇总展示所有信息，问用户：

> 以上是我收集到的信息：
> - 方向: xxx
> - 语言: xxx
> - ...
> 
> 确认无误吗？还是需要修改哪一项？确认后我开始扫描项目。

### Phase 2: 项目扫描

按以下顺序浏览项目，边看边记录关键信息。扫描完成后汇总发现，不要边扫边输出。

**2.1 README / 项目首页：**

读取以下文件（按优先级）：
- `README.md`
- `README.zh.md` 或 `README_zh.md`
- 项目根目录下的 `README*`

提取：
- 项目名称（标题或 h1）
- 项目简介（第一段 after h1）
- 核心功能/模块列表
- 目标用户或业务场景

如果没有 README，从目录名和核心文件推断，并在最终输出中标注"项目信息从代码推断，无 README"。

**2.2 技术栈：**

检查以下文件（按项目语言）：
- `package.json` → dependencies + devDependencies
- `pyproject.toml` / `requirements.txt` / `Pipfile` → Python 依赖
- `Cargo.toml` → Rust 依赖
- `go.mod` → Go 模块
- `pom.xml` / `build.gradle` → Java/Kotlin 依赖
- `Gemfile` → Ruby 依赖
- `docker-compose.yml` / `Dockerfile` → 基础设施组件
- `.github/workflows/` → CI/CD 工具

将技术栈按层级分组：
- 框架: React, Spring Boot, Gin, FastAPI...
- 语言: TypeScript, Java, Go, Python...
- 数据库/存储: PostgreSQL, Redis, MongoDB, Elasticsearch...
- 中间件/消息: Kafka, RabbitMQ...
- 基础设施: Docker, K8s, Nginx...

只列项目实际使用的。如果用户之前给了技术栈补充，加入。如果用户给了排除项，去掉。

**2.3 目录结构：**

用 `ls -la` 或 tree 查看一级目录结构，推断项目类型：
- `src/` / `pages/` / `components/` → 前端
- `api/` / `controllers/` / `services/` / `models/` → 后端
- `etl/` / `pipelines/` / `models/` → 数据
- `k8s/` / `terraform/` / `helm/` → DevOps/Infra

**2.4 Git 日志：**

```bash
git log --oneline --all --author="<git user name>" --since="<duration start if available>" --until="<duration end if available>" | head -50
```

如果没有时间段和用户名信息，使用：
```bash
git log --oneline --all | head -50
```

分析提交内容，提取：
- 高频改动的模块（判断个人负责区域）
- 是否有重大重构、架构变更
- 有没有性能优化、安全修复等可作 STAR 素材的提交

如果仓库无 git 历史，跳过此步，标注"无 git 历史，贡献信息依赖用户输入"。

**2.5 核心代码：**

根据目标方向，选择性深入：
- **后端方向**: 读取 API 路由文件、中间件、数据库模型/DAO、核心业务 service 层
- **前端方向**: 读取路由配置、核心页面组件、状态管理、打包配置
- **数据方向**: 读取 ETL 定义、数据模型、调度配置
- **DevOps 方向**: 读取 CI 配置、Dockerfile、k8s manifests、监控配置

目的：发现技术复杂度信号（如：自研缓存层、复杂状态机、多数据源切换、容错机制等），用于支撑 STAR 描述。

**扫描完成后**，在内部汇总一张表：

| 维度 | 发现 |
|------|------|
| 项目名称 | xxx |
| 业务描述 | xxx |
| 项目规模 | 大致推断（小型/中型/大型/企业级）|
| 核心技术栈 | xxx |
| 个人贡献线索 | xxx |
| 技术亮点 | xxx |

### Phase 3: 简历生成

根据 Phase 1 选择的目标方向和语言，调整输出侧重点。

**3.1 方向适配规则：**

| 方向 | 项目介绍侧重 | STAR 选择偏好 | 技术栈突出 |
|------|-------------|-------------|-----------|
| 后端 | 业务逻辑、API 设计、数据库建模、并发处理 | 高并发策略、事务一致性、缓存设计、中间件集成、性能优化 | Spring Boot/Go/FastAPI + PostgreSQL/Redis/Kafka |
| 前端 | 用户交互、组件架构、状态管理、渲染性能 | 组件封装、性能优化（FCP/LCP）、兼容性处理、工程化建设 | React/Vue + TypeScript + Webpack/Vite |
| 全端 | 需求理解 + 一端深描（通常后端为主，根据实际代码结构判断） | 端到端完整闭环、API 契约设计、跨端协作问题 | 覆盖前后端，突出主导端 |
| 全栈 | 系统全貌、前后端协作、部署与运维 | 架构决策、全链路问题排查、DevOps 实践 | 前后端 + infra，广度优先 |
| 数据研发 | 数据管线、数仓建模、指标体系、数据治理 | ETL 优化、数仓分层设计、数据质量治理、调度链路 | Spark/Flink/dbt/Hive/Airflow |
| DevOps | 基础设施、CI/CD、监控告警、容器化 | 自动化部署、稳定性治理、成本优化、安全合规 | Docker/K8s/Terraform/Jenkins/Prometheus |

**方向为"其他"时**，根据用户描述和项目实际内容自行判断侧重。

**3.2 STAR 编写规则：**

每条 STAR 必须包含三段：
- **背景 (Situation)**: 遇到的问题或业务痛点（1-2 句）
- **行动 (Action)**: 通过什么方法/技术/架构做了什么（2-3 句，动词开头）
- **结果 (Result)**: 实现了什么效果，尽可能带数据（1-2 句）

没有量化数据时，在结果末尾标注 `[需补充数据]`。

**动作动词对照表：**

| 角色 | 中文动词 | English Verbs |
|------|---------|---------------|
| Lead/负责人 | 主导、设计、推动、制定、把控 | Led, Architected, Orchestrated, Spearheaded |
| Core/核心 | 负责、实现、优化、重构、搭建 | Developed, Built, Optimized, Overhauled |
| Contributor/参与者 | 参与、协助、维护、修复 | Contributed to, Assisted, Maintained, Fixed |
| Intern/实习生 | 参与、学习、协助、实现 | Assisted, Contributed to, Implemented |

**3.3 输出格式：**

**中文模版：**

```
## [项目名称]

**[公司名]** | [时间段] | 角色: [个人角色]

**项目简介:** [2-4句话：项目是什么、服务谁、核心价值/规模]

**技术栈:** `技术1` `技术2` `技术3` `...`

**主要职责:**

1. **背景:** [遇到的问题或业务痛点]
   **行动:** [通过xx方法/技术/架构，设计/主导/参与实现了xx]
   **结果:** [实现了xx效果，数据：xxx]

2. **背景:** ...
   **行动:** ...
   **结果:** ...

3. **背景:** ...
   **行动:** ...
   **结果:** ...

**项目成果:** [一句话总结：交付了什么、影响了多少用户/收入/效率提升]
```

**英文模版：**

```
## [Project Name]

**[Company]** | [Duration] | Role: [Your Role]

**Summary:** [2-4 sentences: what the project is, who it serves, core value/scale]

**Tech Stack:** `Tech1` `Tech2` `Tech3` `...`

**Key Contributions:**

1. **Situation:** [Problem or business context]
   **Action:** [What you did to address it — verb-led]
   **Result:** [Outcome with metrics: xxx]

2. **Situation:** ...
   **Action:** ...
   **Result:** ...

3. **Situation:** ...
   **Action:** ...
   **Result:** ...

**Impact:** [One-line summary of delivery and effect]
```

**未提供的信息处理：**
- 无公司名 → 省略 `[公司名]` 行，项目名直接作为标题
- 无时间段 → 省略 `[时间段]`
- 无个人角色 → 省略 `角色:` 字段，动词使用中性的"负责/实现"
- 所有指标缺失 → 每条 Result 后标注 `[需补充数据]`，并在输出末尾提示用户补充

### Phase 4: 输出与修改

输出完整简历段落后，附上提示：

> 以上是生成的简历项目经历。你可以：
> - 具体说"第 N 条改成 xxx"来修改某条
> - 说"技术栈加上/去掉 xxx"来调整技术展示
> - 说"侧重改成 xxx"来调整整体方向
> - 补充量化数据后我可以重新生成 STAR
> 
> 哪里需要改？

**修改循环：**
- 用户提修改意见 → 针对性修改 → 重新输出完整版本 → 再次询问
- 直到用户满意

## 原则

- **一次一个问题**: Phase 1 不连珠炮
- **不编造**: 技术栈只列实际用到的，STAR 结果不编数字
- **角色决定用词**: 参与者不说"主导"，负责人不说"协助"
- **缺数据标注不隐藏**: 没有指标时用 `[需补充数据]`，不装成有数据
- **YAGNI**: 只输出简历的项目经历区块，不输出教育背景、技能总结等
- **保守推断**: 代码能确认的才写，不确定的不写
```

- [ ] **Step 2: Commit**

```bash
git add skills/resume-builder.md
git commit -m "$(cat <<'EOF'
feat: add resume-builder skill

4-phase workflow: conversational info collection → project code scan →
role-tailored STAR generation → output + refinement. Supports 6 role
directions with distinct emphasis rules and bilingual output templates.
EOF
)"
```

---

### Task 2: Create English rationale

**Files:**
- Create: `rationale/skills/en/resume-builder.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Resume Builder Matters

## Trigger Scenario

A developer needs to update their resume. Their project repo has 100+ commits spanning 8 months. They open a blank document and stare at it. What was the business context? What tech stack did we actually use? What did *I* specifically do? After 40 minutes of git-log archaeology and README re-reading, they have 3 bullet points — one of which is "Fixed bugs and improved performance."

Same developer, different approach: they invoke this skill. Six questions later (two required, four skipped), the AI scans the repo, extracts the tech stack, identifies their git contributions, and outputs a 5-STAR project section tailored to "Backend Developer." They refine two bullets in 3 minutes. Done.

## Core Problem

Resume writing has three pain points that a code-scanning skill can solve:

1. **Recall gap**: Developers don't remember everything they did over 6-12 months. Git history has the facts, but nobody reads 500 commit messages to write 5 bullets.
2. **Role framing**: The same project looks different to a frontend developer vs. a backend developer. Manual resume writing often defaults to a generic "worked on X project" description that sells neither role short nor strong — just generic.
3. **STAR discipline**: Most bullet points end up as "Responsible for X module" or "Used React and TypeScript" — activities, not accomplishments. STAR format (Situation → Action → Result) is well-known but hard to self-enforce.

## Why This Must Be a Skill, Not a Script

**Code scanning needs judgment.** A static script can grep for dependencies, but it can't read an API route file and recognize "this is a multi-tenant data isolation pattern worth highlighting in a resume." Only an LLM can inspect code and extract technically meaningful signals.

**Role adaptation is nuanced.** Frontend vs. backend emphasis isn't a simple filter — it's about reframing the same codebase through different lenses. A WebSocket connection is "real-time collaboration infrastructure" to a backend developer and "optimistic UI with server sync" to a frontend developer.

**Information collection must be conversational.** Users skip questions, change their minds, and realize mid-way they want a different role emphasis. A form-based approach can't adapt. A conversational agent can.

## Why STAR Format Is Non-Negotiable

- **Situation** answers "why did this matter" — context that a bullet like "Optimized PostgreSQL queries" lacks
- **Action** answers "what did *you* specifically do" — distinguishes personal contribution from team output
- **Result** answers "so what" — the difference between "wrote code" and "reduced P99 latency from 200ms to 45ms"

## Why Role-Specific Weighting

A full-stack developer's resume that lists 15 technologies with equal weight communicates "jack of all trades, master of none." The same developer applying for a backend role should emphasize backend depth and frame frontend work as "understands the full picture" rather than a co-equal skill. Role weighting gives the reader a clear signal about what the candidate is strongest at.

## Consequences Without This Skill

- Developers spend 30-60 minutes per project manually extracting and framing resume content
- Resume bullets default to activities ("worked on", "used", "responsible for") rather than accomplishments
- The same project across different role applications uses identical language, missing the chance to target the reader
- Quantified results are omitted not because they don't exist, but because the developer forgot to measure or recall them — the `[需补充数据]` marker at least makes the gap visible
```

- [ ] **Step 2: Commit**

```bash
git add rationale/skills/en/resume-builder.md
git commit -m "$(cat <<'EOF'
docs: add English rationale for resume-builder skill

Covers: recall gap, role framing, STAR discipline, why conversational
not scripted, and consequences without the skill.
EOF
)"
```

---

### Task 3: Create Chinese rationale

**Files:**
- Create: `rationale/skills/zh/resume-builder.md`

- [ ] **Step 1: Write the Chinese rationale**

```markdown
# 为什么需要 Resume Builder

## 触发场景

一个开发者要更新简历。自己的项目仓库 100+ 个提交，横跨 8 个月。打开空白文档，不知从哪开始——业务背景是什么来着？实际用了哪些技术栈？我自己具体做了什么？翻了 40 分钟 git log 和 README 后，憋出 3 条干巴巴的描述，其中一条是"修复 bug 并优化性能"。

同一个开发者，换个方式：调用这个 skill。问了 6 个问题（2 个必填，4 个跳过），AI 扫完仓库，提取技术栈，识别个人贡献，输出了一份 5 条 STAR 的"后端开发"简历项目经历。改了 2 条细节，3 分钟搞定。

## 核心问题

简历写作有三个痛点，恰好是代码扫描技能能解决的：

1. **回忆断层**：开发者记不住过去 6-12 个月的每一个细节。Git 历史有事实，但没人会为了写 5 条简历去读 500 条 commit message。
2. **角色错位**：同一个项目，对前端和后台的写法完全不同。手写简历往往默认"参与了 XX 项目开发"，一句话敷衍了事——哪个角色都不突出，只是泛泛。
3. **STAR 难以自执行**：大部分简历条目最终写成"负责 XX 模块"或"使用 React 和 TypeScript"——这是活动描述，不是成果展示。STAR 法则（背景→行动→结果）大家都知道，但自己写的时候很难坚持。

## 为什么必须是一个 Skill 而非脚本

**代码扫描需要判断力。** 静态脚本能 grep 依赖，但它不能读懂 API 路由文件并识别出"这是一个多租户数据隔离方案，值得写进简历"。只有 LLM 能检查代码并提取有技术含量的信号。

**角色适配是重新叙事，不是过滤。** 前端 vs 后端的侧重不是简单的技术栈筛选——是对同一份代码库的重新视角。一条 WebSocket 连接，在后台是"实时协作基础设施"，在前端是"乐观更新的 UI 与服务端数据同步"。

**信息收集必须是对话式的。** 用户会跳过问题、中途改变主意、发现想要另一个方向。表单式收集无法适应这种流。对话式 agent 可以。

## 为什么 STAR 不可妥协

- **背景 (Situation)** 回答"这件事为什么重要"——一条"优化了 PostgreSQL 查询"缺少的就是这个上下文
- **行动 (Action)** 回答"你具体做了什么"——区分个人贡献和团队产出
- **结果 (Result)** 回答"所以呢"——区别是"写了代码"还是"P99 延迟从 200ms 降到 45ms"

## 为什么需要按角色方向适配

一份全栈开发的简历列出 15 项技术、平均用力，传递的信息是"样样通、样样松"。同一个人如果投递后端岗位，应该凸显后端的深度，把前端经验表述为"理解全貌"而非同等权重。角色加权让读者得到一个清晰的信号：候选人最强的方向是什么。

## 没有这个 skill 的后果

- 开发者为每个项目花 30-60 分钟手动提取、组织简历内容
- 简历条目默认为活动叙述（"参与"、"负责"、"使用"）而非成果展示
- 同一个项目投不同岗位用同一种描述，浪费了定向展示的机会
- 量化结果缺失不是因为不存在，而是因为开发者忘了度量或想不起来——`[需补充数据]` 标记至少让缺口可见
```

- [ ] **Step 2: Commit**

```bash
git add rationale/skills/zh/resume-builder.md
git commit -m "$(cat <<'EOF'
docs: add Chinese rationale for resume-builder skill

Covers: recall gap, role framing, STAR discipline, why conversational
not scripted, and consequences without the skill.
EOF
)"
```

---

### Task 4: Update README Skills tables

**Files:**
- Modify: `README.md` (Skills table)
- Modify: `README.zh.md` (Skills table)

- [ ] **Step 1: Update README.md Skills table**

Find the line containing `| [Prompt Composer](skills/prompt-composer.md) |` and add the new skill row before the table's closing:

New row to insert:
```
| [Resume Builder](skills/resume-builder.md) | Scan project code + user info → role-tailored STAR resume section |
```

The resulting Skills table should read:

```
## Skills

| Skill | Description |
|-------|-------------|
| [Prompt Composer](skills/prompt-composer.md) | Turn vague requirements into multi-step dialogue scripts — Ask window designs prompts, Agent window executes |
| [Resume Builder](skills/resume-builder.md) | Scan project code + user info → role-tailored STAR resume section |
```

- [ ] **Step 2: Update README.zh.md Skills table**

Find the line containing `| [Prompt Composer](skills/prompt-composer.md) |` and add the new skill row:

New row to insert:
```
| [Resume Builder](skills/resume-builder.md) | 扫描项目代码 + 用户信息 → 按角色方向生成 STAR 简历项目经历 |
```

The resulting Skills table should read:

```
## Skills

| Skill | 说明 |
|-------|------|
| [Prompt Composer](skills/prompt-composer.md) | 把模糊需求转为多步对话脚本，Ask 窗口设计 prompt，Agent 窗口执行 |
| [Resume Builder](skills/resume-builder.md) | 扫描项目代码 + 用户信息 → 按角色方向生成 STAR 简历项目经历 |
```

- [ ] **Step 3: Commit**

```bash
git add README.md README.zh.md
git commit -m "$(cat <<'EOF'
docs: add resume-builder to Skills table in both READMEs
EOF
)"
```

---

### Task 5: Regenerate stats and create change log

**Files:**
- Modify: `stats.json` (auto-regenerated)
- Create: `docs/变更记录/resume-builder-skill新增_2026-05-17.md`

- [ ] **Step 1: Run stats generation**

```bash
bash scripts/generate-stats.sh
```

Expected: `stats.json` updates `skills` from 1 to 2, `rationale` from 20 to 22.

- [ ] **Step 2: Verify stats output**

```bash
cat stats.json
```

Expected:
```json
{
  "rules": 9,
  "skills": 2,
  "rationale": 22,
  "changelogs": 11,
  "plans": 6,
  "specs": 6
}
```

- [ ] **Step 3: Create change log**

Write `docs/变更记录/resume-builder-skill新增_2026-05-17.md`:

```
# Resume Builder Skill 新增

**时间:** 2026-05-17
**修改文件:**
- `skills/resume-builder.md` (新增)
- `rationale/skills/en/resume-builder.md` (新增)
- `rationale/skills/zh/resume-builder.md` (新增)
- `README.md` (修改 — Skills 表格)
- `README.zh.md` (修改 — Skills 表格)
- `stats.json` (自动生成 — skills 1→2, rationale 20→22)

## 根因分析

**问题现象:** 开发者需要将项目代码转化为简历上的项目经历。手动过程耗时（翻阅 git log + README），且缺乏 STAR 结构化和角色定向。

**根因:** 没有自动化工具连接"项目代码"到"简历输出"。代码扫描需要判断力（识别技术亮点），角色适配需要重新叙事（不同方向侧重不同），信息收集需要对话式（用户跳过、中途改变主意）。

## 修改详情

### 文件: skills/resume-builder.md (新增)

4 阶段工作流:
1. 对话式信息收集（9 项，4 项必填）
2. 项目代码扫描（README → 技术栈 → 目录结构 → git log → 核心代码）
3. 按角色方向生成 STAR 简历（6 个预设方向 + 自定义）
4. 输出 + 精修循环

支持中英文双模版，6 个角色方向（后端/前端/全端/全栈/数据研发/DevOps）。

### 文件: rationale/skills/en/resume-builder.md + zh/resume-builder.md (新增)

分别以英文和中文阐述:
- 触发场景（手动写简历的痛点）
- 核心问题（回忆断层、角色错位、STAR 难以自执行）
- 为什么必须是一个 skill 而非脚本（代码扫描需要判断力、角色适配是重新叙事）
- 为什么 STAR 不可妥协
- 为什么需要按角色方向适配
- 没有这个 skill 的后果

### 文件: README.md + README.zh.md (修改)

Skills 表格新增一行 Resume Builder，中英文描述。

## 解决方案

创建 `resume-builder` skill:
- 对话式信息收集降低启动门槛（必填仅 2 项 + 项目路径）
- 自动化代码扫描提取技术栈、业务描述、个人贡献线索
- 角色定向的 STAR 生成确保不同方向的简历有区分度
- `[需补充数据]` 标记让量化缺失可视化，而非装作有数据
```

- [ ] **Step 4: Commit**

```bash
git add stats.json docs/变更记录/resume-builder-skill新增_2026-05-17.md
git commit -m "$(cat <<'EOF'
chore: regenerate stats + add change log for resume-builder skill

skills: 1→2, rationale: 20→22.
EOF
)"
```

---

### Task 6: Final verification

- [ ] **Step 1: Verify all files exist**

```bash
ls -la skills/resume-builder.md rationale/skills/en/resume-builder.md rationale/skills/zh/resume-builder.md docs/变更记录/resume-builder-skill新增_2026-05-17.md
```

- [ ] **Step 2: Verify git log shows all commits**

```bash
git log --oneline -5
```

- [ ] **Step 3: Verify stats.json is correct**

```bash
cat stats.json
```
