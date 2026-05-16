# 变更记录 — 不确定标记规则新增

**时间:** 2026-05-17

**修改文件:**
- `rules/uncertainty-marking.md` (新建)
- `rationale/uncertainty-marking.md` (新建)
- `README.md` (修改)
- `CLAUDE.md` (修改)

## 变更原因

用户反馈 AI 会编造不存在的 API、猜测业务规则并当作事实。需要一条规则强制 AI 在不确定时显式标记代码，而非默默猜测。

本次变更新增第 8 条规则：不确定标记规则。与第 7 条（状态诚实）联动——代码中有未解决的标记时，状态不能是 DONE。

## 修改详情

### 新建: rules/uncertainty-marking.md

规则文件，定义两种标记类型（[NEEDS VERIFICATION] / [ASSUMPTION]）、三种处理方式（查/标/问）、标记语法和格式要求、与状态诚实的联动机制（Uncertain 字段 + DONE 硬门禁）、适用范围和边界情况。

### 新建: rationale/uncertainty-marking.md

原因解读文件，解释为什么不确定标记对 vibe coding 特别重要——AI 不感知自身不确定性、速度消除自然检查点、幻觉的三种危害（沉没成本/信任降级/隐性债务），以及强制标记如何与 Status Honesty 形成闭环。

### 修改: README.md

- 规则索引表新增第 8 条
- 徽章 `rules-7` → `rules-8`
- 快速开始代码块新增不确定标记规则引用
- 仓库结构树新增两个文件

### 修改: CLAUDE.md

Rules to Load 表格新增 Uncertainty Marking 行。

## 设计决策

- 两条规则分立但联动：Status Honesty 管"状态诚实"，Uncertainty Marking 管"代码诚实"，通过 Uncertain 字段和 DONE 门禁连接
- 两种标记而非一种：[NEEDS VERIFICATION] 和 [ASSUMPTION] 场景不同（API vs. 业务），区分后 reviewer 能精准判断关注点
- 三种处理方式不遗漏：查（能查的查）、标（不能查的标）、问（业务决策的问），覆盖所有不确定场景
