# 变更记录 — Prompt Composer Skill 新增

**时间:** 2026-05-17

**修改文件:**
- `skills/prompt-composer.md` (新建)

## 变更原因

用户在实践中发现，把"设计 prompt"和"执行 prompt"拆成两个独立会话能大幅提升 AI 输出质量。需要一个可复用的 skill，在 Ask 模式下帮用户把模糊需求转为结构化的多步对话脚本，供 Plan/Agent 窗口使用。

## 修改详情

### 新建: skills/prompt-composer.md

自包含的 Claude Code skill 文件，可直接复制到任何项目的 `skills/` 目录使用。

Skill 工作流程：
1. 一次一个问题澄清需求
2. 定义执行窗口 AI 角色
3. 拆分为 3-6 个独立可验证的步骤
4. 输出角色定义 + 对话脚本
5. 提示用户可以继续修改

## 设计决策

- 单一文件可复制，不依赖其他工具或配置
- 只产出 prompt，不写实现代码 — 边界清晰
- 和 brainstorming skill 互补：brainstorming 出 spec → prompt-composer 出执行脚本
- 使用中文编写，匹配用户工作语言
