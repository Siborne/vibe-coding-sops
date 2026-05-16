# 变更记录 — 状态诚实规则新增

**时间:** 2026-05-17

**修改文件:**
- `rules/status-honesty.md` (新建)
- `rationale/status-honesty.md` (新建)
- `README.md` (修改)
- `CLAUDE.md` (修改)

## 变更原因

用户反馈 AI 存在"假完成"问题 — 代码写完就声称"做完了"，但实际未经验证、或者刻意忽略了未完成的部分。需要一条规则强制 AI 诚实报告完成状态。

本次变更新增第 7 条规则：状态诚实规则。

## 修改详情

### 新建: rules/status-honesty.md

规则文件，定义四种状态（DONE / PENDING VERIFICATION / BLOCKED / PARTIAL）、状态块格式、DONE 必须附带验证清单的要求、用户反馈处理流程、适用范围和边界情况。

### 新建: rationale/status-honesty.md

原因解读文件，解释为什么状态诚实对 vibe coding 特别重要 — AI 速度太快容易跳过验证、多轮对话中假完成会层层放大、以及为什么需要结构化状态块而非依赖 AI 自觉。

### 修改: README.md

- 规则索引表新增第 7 条
- 徽章 `rules-6` → `rules-7`
- 快速开始代码块新增状态诚实规则引用
- 仓库结构树新增两个文件

### 修改: CLAUDE.md

Rules to Load 表格新增 Status Honesty 行。

## 设计决策

- 拆分为两条规则：本次只做"状态诚实"，"不确定标记"留作后续规则
- 四种状态而非三种：`PARTIAL` 独立于 `BLOCKED` 和 `PENDING VERIFICATION`，因为"部分完成"是一个明确且常见的中间态
- 验证清单强制附带证据，防止 AI 口头说 DONE 但实际不验证
