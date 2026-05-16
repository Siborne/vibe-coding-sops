# vibe-coding-sops

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/rules-5-4caf50.svg" alt="Rules: 5">
  <img src="https://img.shields.io/badge/status-active-success.svg" alt="Status: Active">
  <img src="https://img.shields.io/badge/vibe%20coding-essential-f39f37.svg" alt="Vibe Coding: Essential">
</p>

> Vibe Coding 时载入的规则集合。每条规则说清楚"做什么"，每条规则的原因解释回答"为什么"。

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
```

## 规则索引

| # | 规则 | 说明 |
|---|------|------|
| 1 | [代码变更记录规则](rules/code-change-log.md) | 每次修改必须创建结构化变更记录，含根因分析 + 修改前后对比 |
| 2 | [有意义注释规则](rules/meaningful-comments.md) | 七类值得写的注释：TODO / 参考资料 / 正确性说明 / 血泪教训 / 常数理由 / 承重细节 / 为什么不用 X |
| 3 | [README 编写规则](rules/readme-structure.md) | 漏斗式组织，依次回答：做什么 → 为什么在乎 → 怎么用 → 怎么装 |
| 4 | [提交信息规则](rules/commit-message.md) | 提交信息是 git 的历史记录，应回答：问题、方案对比、取舍、意外点 |
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则：对事不对人、可操作建议、提问、解释为什么、区分阻断、肯定优点、适可而止 |

每条规则对应的"为什么"详见 [rationale/](rationale/) 目录。

## 仓库结构

```
vibe-coding-sops/
├── rules/          # 规则文件（做什么、怎么做）
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   └── code-review.md
├── rationale/      # 原因解释（为什么需要这条规则）
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   └── code-review.md
├── CLAUDE.md
├── LICENSE
└── README.md
```

## 许可

MIT © 2026 Siborne
