# 新增 Agent Prompt Engineering 技能

## 基本信息

- **时间**：2026-05-17
- **修改文件**：
  - `skills/agent-prompt-engineering.md`（新建）
  - `rationale/skills/zh/agent-prompt-engineering.md`（新建）
  - `rationale/skills/en/agent-prompt-engineering.md`（新建）
  - `README.md`（新增 skill 到 Skills 表格）
  - `CLAUDE.md`（新增 Skills to Load 表格 + Adding a New Skill 章节 + 更新 Repository Structure）
  - `stats.json`（自动更新）

## 根因分析

用户在阅读 Agent 开发相关资料时，发现 AI 给 AI 写提示词通常质量一般。需要一套系统性的提示词工程方法论，专门用于 Agent 应用开发场景——即开发者构建调用 LLM API 的软件产品时，为产品内置 Agent 设计 prompt。

区别于已有的 `prompt-composer` skill（用于 IDE 里驱动 AI 做开发），本 skill 关注的是**产品 Agent 的提示词设计**。

## 修改详情

### 文件: skills/agent-prompt-engineering.md（新建）

新建 5 种提示词工程技巧的完整参考文档：

1. **CoT 思维链** — 引导 Agent 逐步推理，展示过程而非直接给答案
2. **结构化提示词** — 角色/任务/要求/输出格式四模块模板
3. **正反面示例引导** — 通过对比示范让 Agent 理解标准
4. **分治法** — 复杂任务拆解为独立子问题，分步解决
5. **数据结构转换** — 自然语言转 JSON 等结构化数据，包含类型约束

每项技巧包含：适用场景、应用代码示例（Python API 调用）、原则。附带技巧选择指南、组合使用建议、常见错误表、与应用代码的集成建议。

### 文件: rationale/skills/zh/agent-prompt-engineering.md（新建）

中文理由文档，包含触发场景（智能客服 Agent 开发的典型翻车案例）、核心问题（开发者用"给人写指令"的方式给 LLM 写 prompt）、为什么必须是独立 skill、5 种技巧与 Agent 失败模式的对应关系、缺失后果。

### 文件: rationale/skills/en/agent-prompt-engineering.md（新建）

英文理由文档，内容与中文版对应。

## 解决方案

按照现有项目惯例（`skills/<name>.md` + `rationale/skills/{zh,en}/<name>.md`），为用户提供了一套可直接参考的 Agent 提示词工程方法论。技巧排序按"从简单到复杂、从通用到专用"递增，支持增量使用。
