# 新增 AGENTS.md 案例集

## What

- 新增 `docs/agents-md/README.md`，专门记录公开的 `AGENTS.md` / `CLAUDE.md` 项目规则文件。
- 收录 Peter Steinberger 的两份 `AGENTS.md`：
  - OpenClaw 项目版：10 段结构 + ④ 原文摘录 + 可复用点
  - 个人版：7 段结构 + ① 原文摘录 + 可复用点
- 增加两份文件的共同点、同源的其他 `AGENTS.md` 索引、记录模板，以及"案例变项目规则"的步骤。
- 在 `skills/atomic/expert-ai-rules/SKILL.md` 和 `.claude/skills/expert-ai-rules.md` 的来源地图下增加案例集链接。
- 更新 `README.md` / `README.zh.md` 的 docs 结构和案例集入口。

## Why

用户指出源材料里一部分是通用办公模板，其余内容更偏代码协作。原来的 `expert-ai-rules` 技能把两类内容放在一起，缺少专门记录 `AGENTS.md` 原文结构和摘录的位置。

因此新增一份独立文档，按案例方式记录 `AGENTS.md`：

- 办公模板继续留在技能里，方便直接复制使用。
- 代码类规则按 `AGENTS.md` 案例单独归档，保留原文结构和摘录，便于后续对照和复用。
- 技能只保留来源索引，不把长原文全部塞进 `SKILL.md`，避免主文件继续膨胀。

## 收录范围

本次重点收录用户指定的两份 Peter Steinberger `AGENTS.md`：OpenClaw 项目版和个人版。原文中还有 Jesse Vincent 的 superpowers `AGENTS.md` 和 Mitchell Hashimoto 的 Ghostty `AGENTS.md`，先在"同源的其他 AGENTS.md"中列索引，后续可按同一模板补充。

## Before / After

**Before**：`expert-ai-rules` 技能有来源地图，但没有单独的 `AGENTS.md` 案例文档；OpenClaw 项目版和个人版的段落结构、原文摘录没有集中位置。

**After**：`docs/agents-md/README.md` 成为 `AGENTS.md` 案例入口，包含两份 Peter 文件的完整结构、原文摘录和复用方法；技能与 README 均链接到该文档。
