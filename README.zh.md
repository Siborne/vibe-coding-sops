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

> AI 辅助编程（vibe coding）规则集合。每条规则说清楚"做什么"，每条规则的原因解释回答"为什么"。[English](README.md)

## 为什么你需要这个

AI 辅助编程速度极快，但速度不等于质量。没有规则约束的 vibe coding 会导致：

- 代码改完了，不知道改了什么（没有变更记录）
- 三个月后的 `git blame` 返回 "fix bug"，毫无信息量
- AI 生成的代码表面通顺，但存在隐性边界问题
- 团队代码风格三天后变成三种

这个仓库把 vibe coding 中必须遵守的**规则**和**理由**写下来，放进 Claude Code 的项目记忆中，确保每次 AI 辅助编码都在同一套约束下运行。

## 快速开始

把本仓库克隆到本地，在 Claude Code 项目中引用规则文件：

```
# 在你的项目 CLAUDE.md 中引用
本项目遵循 vibe-coding-sops 中的规则，详见：
- 有意义注释规则: rules/code-quality/meaningful-comments.md
- 不确定标记规则: rules/code-quality/uncertainty-marking.md
- 代码风格声明规则: rules/code-quality/code-style-declaration.md
- 提交信息规则: rules/workflow/commit-message.md
- 代码评审规则: rules/workflow/code-review.md
- 分支与 PR 工作流规则: rules/workflow/branch-pr-workflow.md
- 代码变更记录规则: rules/documentation/code-change-log.md
- README 编写规则: rules/documentation/readme-structure.md
- 状态诚实规则: rules/communication/status-honesty.md
```

## 规则索引

规则按四个类别组织。

### 代码质量 [code-quality]
约束代码怎么写、并对隐含的不确定性加以保护的规则。

| 规则 | 说明 |
|------|------|
| [有意义注释规则](rules/code-quality/meaningful-comments.md) | 七类值得写的注释：TODO / 参考资料 / 正确性说明 / 血泪教训 / 常数理由 / 承重细节 / 为什么不用 X |
| [不确定标记规则](rules/code-quality/uncertainty-marking.md) | AI 不确定时必须显式标记：[NEEDS VERIFICATION] 标记 API/库不确定性，[ASSUMPTION] 标记业务假设，与状态诚实联动阻止 DONE |
| [代码风格声明规则](rules/code-quality/code-style-declaration.md) | 开发前必须声明风格基准、决策偏好、禁止项；不允许没有风格声明就开始写代码 |

### 工作流 [workflow]
规范变更如何经过提交、评审与分支的规则。

| 规则 | 说明 |
|------|------|
| [提交信息规则](rules/workflow/commit-message.md) | 提交信息是 git 的历史记录，应回答：问题、方案对比、取舍、意外点 |
| [代码评审规则](rules/workflow/code-review.md) | 评审七原则：对事不对人、可操作建议、提问、解释为什么、区分阻断、肯定优点、适可而止 |
| [分支与 PR 工作流规则](rules/workflow/branch-pr-workflow.md) | 分支命名、PR 范围、rebase 同步、合并前 checklist、reviewer 合并后清理 |

### 文档 [documentation]
约束随代码一起交付的文档产物的规则。

| 规则 | 说明 |
|------|------|
| [代码变更记录规则](rules/documentation/code-change-log.md) | 每次修改必须创建结构化变更记录，含根因分析 + 修改前后对比 |
| [README 编写规则](rules/documentation/readme-structure.md) | 漏斗式组织，依次回答：做什么 → 为什么在乎 → 怎么用 → 怎么装 |

### 沟通 [communication]
约束 AI 如何诚实报告状态的规则。

| 规则 | 说明 |
|------|------|
| [状态诚实规则](rules/communication/status-honesty.md) | AI 每次回复必须附状态块，四种状态（DONE/PENDING VERIFICATION/BLOCKED/PARTIAL），DONE 必须附带验证清单 |

每条规则对应的"为什么"详见 [rationale/](rationale/) 目录。

## Skills

技能按三个类别组织。

### 工程类 [engineering]
按既定流程逐步执行、每步有可验证产出的固定流程技能。

| Skill | 说明 |
|-------|------|
| [GitHub PR Workflow](skills/engineering/git-collaboration/github-pr-workflow/SKILL.md) | 企业级 Fork + Feature Branch + PR 协作开发流程，禁止直接提交 main |

### 对话类 [conversational]
以多轮对话为主、先澄清信息再产出结果的技能。

| Skill | 说明 |
|-------|------|
| [Prompt Composer](skills/conversational/requirement/prompt-composer/SKILL.md) | 把模糊需求转为多步对话脚本，Ask 窗口设计 prompt，Agent 窗口执行 |
| [Resume Builder](skills/conversational/interview/resume-builder/SKILL.md) | 对话式访谈 + 项目代码扫描，生成角色定制的 STAR 简历段落 |

### 原子类 [atomic]
单一主题、职责最小、可独立调用可组合的技能单元。

| Skill | 说明 |
|-------|------|
| [Agent Prompt Engineering](skills/atomic/agent-prompt-engineering/SKILL.md) | 5 种生产级 Agent prompt 编写技巧 — 思维链、结构化模版、正反例、分而治之、数据结构转换 |

完整的分类树与规划中的子类见 [skills/](skills/)（工程类：git-collaboration · code-quality · testing · delivery；对话类：requirement · interview · brainstorm）。

## 仓库结构

```
vibe-coding-sops/
├── rules/               # 规则文件（做什么、怎么做），按 4 个类别组织
│   ├── code-quality/    #   有意义注释、不确定标记、代码风格声明
│   ├── workflow/        #   提交信息、代码评审、分支与 PR
│   ├── documentation/   #   代码变更记录、README 编写
│   └── communication/   #   状态诚实
├── rationale/           # 原因解读（为什么需要这条规则）
│   ├── rules/           #   对应 rules/：<category>/<en|zh>/<name>.md
│   └── skills/          #   对应 skills/：<category>/<subcategory>/<name>/<en|zh>.md
├── skills/              # 可复用 AI 技能，按 3 个类别组织
│   ├── engineering/     #   固定流程技能（git-collaboration、code-quality、testing、delivery）
│   ├── conversational/  #   对话驱动技能（requirement、interview、brainstorm）
│   └── atomic/          #   单一用途技能单元
├── docs/
│   ├── superpowers/
│   │   ├── plans/       # 实现计划
│   │   └── specs/       # 设计规格
│   └── 变更记录/         # 代码变更记录
├── scripts/             # 辅助脚本
│   └── generate-stats.sh
├── stats.json           # 项目统计数据（驱动上方徽章）
├── CLAUDE.md            # Claude Code 项目记忆
├── LICENSE
├── README.md            # 英文版说明
└── README.zh.md         # 中文版（本文件）
```

## 许可

MIT © 2026 Siborne
