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
