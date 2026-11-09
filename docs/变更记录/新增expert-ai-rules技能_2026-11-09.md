# 新增 expert-ai-rules 技能

## What

把下载的《大佬AI规则文件-精华版》整理为项目标准格式，新增一个原子类技能。

- 新增 `skills/atomic/expert-ai-rules/SKILL.md`
  - 按项目 frontmatter 规范补齐 `name` / `title` / `description` / `type` / `category` / `triggers` / `tags`
  - 将原文的 11 份规则重组为 12 条核心规则，分为"想清楚 / 做对 / 说清楚 / 守边界"四条主线
  - 保留原文的固定验证流程、来源地图和 12 段通用办公模板
  - 增加项目级 `CLAUDE.md` / `AGENTS.md` 生成步骤、常见反模式和边界说明
- 新增 `rationale/skills/atomic/expert-ai-rules/zh.md` 与 `en.md`
- 更新 `skills/atomic/README.md`、`README.md`、`README.zh.md`、`CLAUDE.md` 的技能索引
- 同步 `.claude/skills/expert-ai-rules.md`
- 重新生成 `stats.json`

## Why

用户要求把 `S:\Users\90438\Downloads\大佬AI规则文件-精华版.md` 转成符合本项目的格式。

源文件是 PDF 提取的多专家规则合集，存在大量断行、空格和分页标记噪声。项目中的 `rules/` 是原子约束，一条规则只解决一个问题；这份材料覆盖写代码、提问、写作、Git 操作等 12 个主题，直接塞进单条 rule 会破坏原子性，也会和现有的 `uncertainty-marking`、`status-honesty`、`code-review` 等规则重复。

因此按 `skills/atomic/` 的知识单元收录：它提供可复用的协作基线和模板，不替代任何现有规则。

## Before / After

**Before**：源文件是一段连续的 PDF 提取文本，没有 frontmatter、没有分类、没有索引、没有 rationale，标题和正文混在一起。

**After**：`skills/atomic/expert-ai-rules/SKILL.md` 是带 frontmatter、触发条件、核心规则、来源地图和模板的结构化技能文件；rationale 提供中英文的"为什么"；README、CLAUDE.md、atomic 索引和 stats 已同步。

## 取舍说明

- 保留 11 份规则的核心内容和原文中的关键例子，删除 PDF 分页标记、OCR 断行和重复的星数/日期信息。
- 原文中只给出段落标题、没有展开原文的部分，按标题含义概括，不额外编造具体细节。
- Boris 的 `bun` 命令作为示例保留，并明确标注"不要直接照搬，替换成当前项目的真实命令"。
- 原文的通用办公模板按 12 个板块保留，改为可直接复制的 `text` 代码块。
