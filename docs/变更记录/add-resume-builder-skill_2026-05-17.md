# 新增 Resume Builder 技能文件 _2026-05-17

## 基本信息

- **时间**: 2026-05-17
- **修改文件**:
  - `skills/resume-builder.md` (新建)
  - `README.md` (修改)
  - `README.zh.md` (修改)
  - `stats.json` (自动生成)

## 根因分析

- **问题现象**: 项目缺少简历生成技能，用户无法让 AI 根据项目代码自动生成角色定制的简历经历。
- **根因**: 技能目录下只有 `prompt-composer.md` 和 `agent-prompt-engineering.md`，没有简历相关技能。

## 修改详情

### 文件: skills/resume-builder.md (新建)

新建完整的技能文件，包含 4 阶段工作流：
1. Phase 1: 对话式信息收集（9 个问题，逐题询问）
2. Phase 2: 项目代码扫描（README、技术栈、目录结构、Git 日志、核心代码）
3. Phase 3: 简历生成（6 个方向适配规则 + STAR 编写规则 + 中英文模版）
4. Phase 4: 输出与修改循环

### 文件: README.md (修改)

在 Skills 表格中新增 Resume Builder 条目。

### 文件: README.zh.md (修改)

在 Skills 表格中新增 Resume Builder 条目（中文说明）。

### 文件: stats.json (自动生成)

`skills` 计数从 2 更新为 3。

## 解决方案

按照项目技能文件的标准格式，创建了一个完整的简历生成技能文件，遵循以下原则：
- 一次一个问题（对话式交互）
- 不编造数据（缺失数据标注 `[需补充数据]`）
- 角色决定用词（参与者不说"主导"）
- 保守推断（代码能确认的才写）
