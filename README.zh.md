# vibe-coding-sops

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
- 代码变更记录规则: rules/code-change-log.md
- 有意义注释规则: rules/meaningful-comments.md
- README 编写规则: rules/readme-structure.md
- 提交信息规则: rules/commit-message.md
- 代码评审规则: rules/code-review.md
- 代码风格声明规则: rules/code-style-declaration.md
- 分支与 PR 工作流规则: rules/branch-pr-workflow.md
- 状态诚实规则: rules/status-honesty.md
- 不确定标记规则: rules/uncertainty-marking.md
```

## 规则索引

| # | 规则 | 说明 |
|---|------|------|
| 1 | [代码变更记录规则](rules/code-change-log.md) | 每次修改必须创建结构化变更记录，含根因分析 + 修改前后对比 |
| 2 | [有意义注释规则](rules/meaningful-comments.md) | 七类值得写的注释：TODO / 参考资料 / 正确性说明 / 血泪教训 / 常数理由 / 承重细节 / 为什么不用 X |
| 3 | [README 编写规则](rules/readme-structure.md) | 漏斗式组织，依次回答：做什么 → 为什么在乎 → 怎么用 → 怎么装 |
| 4 | [提交信息规则](rules/commit-message.md) | 提交信息是 git 的历史记录，应回答：问题、方案对比、取舍、意外点 |
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则：对事不对人、可操作建议、提问、解释为什么、区分阻断、肯定优点、适可而止 |
| 6 | [代码风格声明规则](rules/code-style-declaration.md) | 开发前必须声明风格基准、决策偏好、禁止项；不允许没有风格声明就开始写代码 |
| 7 | [分支与 PR 工作流规则](rules/branch-pr-workflow.md) | 分支命名、PR 范围、rebase 同步、合并前 checklist、reviewer 合并后清理 |
| 8 | [状态诚实规则](rules/status-honesty.md) | AI 每次回复必须附状态块，四种状态（DONE/PENDING VERIFICATION/BLOCKED/PARTIAL），DONE 必须附带验证清单 |
| 9 | [不确定标记规则](rules/uncertainty-marking.md) | AI 不确定时必须显式标记：[NEEDS VERIFICATION] 标记 API/库不确定性，[ASSUMPTION] 标记业务假设，与状态诚实联动阻止 DONE |

每条规则对应的"为什么"详见 [rationale/](rationale/) 目录。

## Skills

| Skill | 说明 |
|-------|------|
| [Prompt Composer](skills/prompt-composer.md) | 把模糊需求转为多步对话脚本，Ask 窗口设计 prompt，Agent 窗口执行 |

## 仓库结构

```
vibe-coding-sops/
├── rules/               # 规则文件（做什么、怎么做）
│   └── ...              # 9 条规则
├── rationale/           # 原因解读（为什么需要这条规则）
│   ├── rules/
│   │   ├── en/          # 规则解读 — 英文（9 条）
│   │   └── zh/          # 规则解读 — 中文（9 条）
│   └── skills/
│       ├── en/          # skill 解读 — 英文
│       └── zh/          # skill 解读 — 中文
├── skills/              # 可复用 AI 技能
│   └── ...
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
