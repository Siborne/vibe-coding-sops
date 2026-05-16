# Uncertainty Marking Rule — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add rule #8 "Uncertainty Marking" — AI must explicitly mark uncertain code with `[NEEDS VERIFICATION]` or `[ASSUMPTION]` tags, integrates with Status Honesty via `Uncertain` status field.

**Architecture:** Two new files (`rules/uncertainty-marking.md`, `rationale/uncertainty-marking.md`) plus updates to `README.md`, `CLAUDE.md`, and a change log. This rule integrates with rule #7 (Status Honesty) by adding an `Uncertain` field to the status block and a hard gate preventing DONE when unresolved tags exist.

**Tech Stack:** Markdown only.

---

### File Structure

```
Create:
  rules/uncertainty-marking.md        # The rule: two tag types, syntax, integration with Status Honesty
  rationale/uncertainty-marking.md    # Why uncertainty marking matters, hallucination problem
  docs/变更记录/uncertainty-marking规则新增_2026-05-17.md  # Change log

Modify:
  README.md                           # Rule #8 to index, badge 7→8, quick-start, structure tree
  CLAUDE.md                           # Rules to Load table
```

---

### Task 1: Create the Rule File

**Files:**
- Create: `rules/uncertainty-marking.md`

- [ ] **Step 1: Write the rule file**

```markdown
# 不确定标记规则

AI 遇到不确定的 API、库、语法、业务规则时，必须显式标记，禁止编造一个"看起来合理"的答案。

## 两种标记类型

| 标记 | 使用场景 | 示例 |
|------|---------|------|
| `[NEEDS VERIFICATION]` | 对 API/库/语法不确定，写了但未确认是否存在 | 编了一个 `fetchUserData()` 函数名，不确定这个 API 存在 |
| `[ASSUMPTION: xxx]` | 对业务逻辑做了假设，未跟用户确认 | 假设"订单超时 30 分钟自动取消"，没问过产品 |

## 不确定时的三种处理方式

AI 遇到不确定时，必须从以下三种方式中选一种：

1. **查** — 如果可以查文档/搜索确认，先确认再写代码
2. **标** — 如果无法确认但必须继续，用 `[NEEDS VERIFICATION]` 标记
3. **问** — 如果是业务决策，用 `[ASSUMPTION: xxx]` 标记并询问用户

## 标记语法

标记放在不确定代码的上一行，作为注释：

```
// [NEEDS VERIFICATION] 不确定此 API 是否存在 — 上线前查文档确认
const user = await auth.fetchUserById(userId);

// [ASSUMPTION: 假设订单超时时间为 30 分钟 — 请确认业务规则]
if (Date.now() - order.createdAt > 30 * 60 * 1000) {
    cancelOrder(order);
}
```

### 标记格式要求

每个标记必须包含：
- **标记类型**：`[NEEDS VERIFICATION]` 或 `[ASSUMPTION: 具体假设内容]`
- **说明文字**：哪里不确定、为什么不确定

不写说明文字的裸标记 `[NEEDS VERIFICATION]` 不满足要求。

## 禁止行为

- ❌ 编造不存在的 API、库、函数签名
- ❌ 把猜测的业务规则当作既定事实
- ❌ 编一个"合理"的默认值但不告诉用户这是编的

## 与状态诚实规则联动

### Uncertain 字段

状态块增加可选字段 `Uncertain`，列出本轮代码中所有未解决的标记：

```
---
Status: PENDING VERIFICATION
Done: 实现了订单取消逻辑
Uncertain:
- [ASSUMPTION: 超时 30 分钟] — orders.js L42
- [NEEDS VERIFICATION] — auth.fetchUserById 未确认 — auth.js L15
Next: 确认以上标记后可升级到 DONE
```

### DONE 硬门禁

代码中存在未解决的 `[NEEDS VERIFICATION]` 或 `[ASSUMPTION]` 标记时，**状态不能是 DONE**。最多只能到 `PENDING VERIFICATION`，直到所有标记被清除。

### 用户清除标记

- 用户说"这个 API 是对的" → AI 删除对应标记
- 用户说"改成 X" → AI 修正代码 + 删除标记
- 用户说"全部确认" → AI 删除所有标记，可升级到 DONE

### 双重违规

如果代码中存在标记但状态块的 `Uncertain` 字段为空，同时违反本规则和状态诚实规则。

## 适用范围

**适用场景：**
- 所有产生代码的任务
- 第三方库/API 调用、业务逻辑、数据边界处理尤其关键
- 样板代码/模板代码中 AI 不确定的部分（包括 import 语句）

**不适用场景：**
- 纯问答/信息查询，无代码产出
- 从项目现有代码中推断出的模式（跟随现有风格不算假设）

## 边界情况

| 场景 | 要求 |
|------|------|
| AI 不确定但能查文档确认 | 先查再写，不要偷懒直接标记 |
| 用户说"先这样写，我后面确认" | 保留标记，状态保持 `PENDING VERIFICATION` |
| AI 100% 确定但仍然写错了 | 不算违反本规则 — 本规则管的是"明知不确定还编"，不管未知错误 |
| 累计超过 5 个未解决标记 | 暂停实现，问用户：逐个确认 vs. 继续标记 |
| AI 写的样板代码且确定正确 | 不需要标记 |
| 标记存在但 `Uncertain` 字段缺失 | 同时违反本规则和状态诚实规则 |
```

- [ ] **Step 2: Verify the file was created**

Run: `ls -la "S:/Sto-box/700-project/vibe-coding-sops/rules/uncertainty-marking.md"`
Expected: file exists, non-zero size.

- [ ] **Step 3: Commit**

```bash
git add rules/uncertainty-marking.md
git commit -m "$(cat <<'EOF'
add rule #8: Uncertainty Marking — mark uncertain code, never fabricate

Two tags: [NEEDS VERIFICATION] for API/library uncertainty,
[ASSUMPTION: ...] for guessed business rules. Integrates with
Status Honesty via Uncertain field and DONE hard gate.
EOF
)"
```

---

### Task 2: Create the Rationale File

**Files:**
- Create: `rationale/uncertainty-marking.md`

- [ ] **Step 1: Write the rationale file**

```markdown
# 为什么需要不确定标记

## 触发场景

AI 被要求添加用户认证。它写了 `import { AuthClient } from '@company/auth-sdk'`，调用了 `AuthClient.authenticate()`。import 路径不存在，方法签名是错的，SDK 实际叫 `@company/identity`。用户到运行时才发现——AI 的代码"看起来没问题"，所以没被质疑。

## 核心问题

AI 模型不知道自己不知道什么。当它对一个库或业务规则不确定时，它会预测统计上最可能的答案——这往往是一个看起来很有说服力的幻觉。没有显式标记，用户无法区分"我确定这是对的"和"这是一个合理的猜测"。

## 在 vibe coding 场景下更关键

手写代码时，你能感受到不确定：你会暂停、查 Google、问同事。AI 编码没有这种摩擦——模型瞬间生成代码且语法自信，不管它是否真的知道答案。速度消除了人类开发者依赖的自然检查点——"等等，我确定吗？"。

具体到"幻觉"的危害：

- **沉没成本**：用户基于幻觉代码继续开发，后续代码依赖一个不存在的 API。发现时需要回退的不止那一行，而是基于它的所有代码
- **信任降级**：每次发现幻觉，用户对 AI 的信任就降一级。最终用户会逐行验证所有 AI 输出——AI 的加速效果归零
- **隐性债务**：有些幻觉不会立即暴露（比如错误的默认值），它们潜伏到特定条件触发时才炸

## 为什么必须是强制标记而非靠 AI 自觉

- **标记成本极低**：写一行 `[NEEDS VERIFICATION]` 只需 3 秒，根除一个潜在 bug 的收益远超成本
- **可审计**：代码 review 时，标记过的代码自动获得更高 scrutiny——这不是 AI 的错，是标记提醒了 reviewer
- **与 Status Honesty 联动**：标记 → `Uncertain` 字段 → DONE 被阻止，形成闭环。AI 不能"忘记"标记的代码
- **三种处理方式覆盖全部**：查/标/问三种路径没有遗漏，AI 不会因为"不知道该怎么做"而跳过

## 没有这条规则的后果

- 幻觉 API 进入代码库，运行时才报错，浪费数小时调试
- 错误的业务假设成为"既定规则"，在后续代码中被重复引用
- 用户学会不信任 AI 输出，逐行验证——抵消生产力增益
- AI 生成 vs. AI 验证的边界模糊，code review 更难判断重点
```

- [ ] **Step 2: Verify the file was created**

Run: `ls -la "S:/Sto-box/700-project/vibe-coding-sops/rationale/uncertainty-marking.md"`
Expected: file exists, non-zero size.

- [ ] **Step 3: Commit**

```bash
git add rationale/uncertainty-marking.md
git commit -m "$(cat <<'EOF'
add rationale for rule #8: why Uncertainty Marking matters

Explains the hallucination problem, why vibe coding speed eliminates
natural uncertainty checkpoints, and why mandatory tags with Status
Honesty integration create a closed loop against fabricated code.
EOF
)"
```

---

### Task 3: Update README.md

**Files:**
- Modify: `README.md`

This task makes 4 edits to README.md. The current state has 7 rules and badge `rules-7`.

- [ ] **Step 1: Add rule #8 to the index table**

After row 7 in the `## 规则索引` table, add:

```markdown
| 8 | [不确定标记规则](rules/uncertainty-marking.md) | AI 不确定时必须显式标记：[NEEDS VERIFICATION] 标记 API/库不确定性，[ASSUMPTION] 标记业务假设，与状态诚实联动阻止 DONE |
```

- [ ] **Step 2: Update badge from rules-7 to rules-8**

Find the badge line. Change `rules-7` → `rules-8` in both URL and alt text:
- `rules-7-4caf50.svg` → `rules-8-4caf50.svg`
- `Rules: 7` → `Rules: 8`

- [ ] **Step 3: Add to quick-start block**

In the `## 快速开始` code block, add after the status-honesty line:

```
- 不确定标记规则: rules/uncertainty-marking.md
```

- [ ] **Step 4: Add to repository structure tree**

In `## 仓库结构`, add `uncertainty-marking.md` to both the `rules/` listing and the `rationale/` listing, after the existing `status-honesty.md` entries.

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "$(cat <<'EOF'
add rule #8 Uncertainty Marking to README index, badge, and structure tree
EOF
)"
```

---

### Task 4: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Add rule #8 to the Rules to Load table**

After the Status Honesty row, add:

```markdown
| Uncertainty Marking | `rules/uncertainty-marking.md` | Tag uncertain code with [NEEDS VERIFICATION] or [ASSUMPTION: ...]; integrates with Status Honesty via Uncertain field; DONE blocked while tags exist |
```

- [ ] **Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "$(cat <<'EOF'
add rule #8 Uncertainty Marking to CLAUDE.md Rules to Load table
EOF
)"
```

---

### Task 5: Create Change Log

**Files:**
- Create: `docs/变更记录/uncertainty-marking规则新增_2026-05-17.md`

- [ ] **Step 1: Write the change log**

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
git add docs/变更记录/uncertainty-marking规则新增_2026-05-17.md
git commit -m "$(cat <<'EOF'
add change log for rule #8 Uncertainty Marking addition
EOF
)"
```

---

### Task 6: Final Verification

- [ ] **Step 1: Verify git status is clean**

Run: `git status`
Expected: `nothing to commit, working tree clean` (or only pre-existing untracked files)

- [ ] **Step 2: Verify file structure**

Run: `ls -1 rules/ && echo "---" && ls -1 rationale/`
Expected: 8 files in each directory, including `uncertainty-marking.md`

- [ ] **Step 3: Verify CLAUDE.md has 8 rules**

Run: `grep -c "rules/" CLAUDE.md`
Expected: 8

---

## Plan Self-Review

### 1. Spec coverage

| Spec requirement | Covered by |
|-----------------|------------|
| Two tag types with table | Task 1 (两种标记类型 section) |
| Three permitted responses (查/标/问) | Task 1 (三种处理方式 section) |
| Forbidden behaviors | Task 1 (禁止行为 section) |
| Marking syntax with code examples | Task 1 (标记语法 section) |
| Tag format requirements (type + explanation) | Task 1 (标记格式要求 section) |
| Integration: Uncertain field in status block | Task 1 (Uncertain 字段 section) |
| Integration: DONE hard gate | Task 1 (DONE 硬门禁 section) |
| User clears tags (3 ways) | Task 1 (用户清除标记 section) |
| Double violation (tags exist, Uncertain empty) | Task 1 (双重违规 section) |
| Scope: applies to code-producing tasks | Task 1 (适用范围 section) |
| Scope: NOT pure Q&A, NOT inferred patterns | Task 1 (适用范围 section) |
| Edge cases table (6 scenarios) | Task 1 (边界情况 section) |
| Rationale: trigger scenario | Task 2 (触发场景 section) |
| Rationale: core problem | Task 2 (核心问题 section) |
| Rationale: vibe coding relevance | Task 2 (在 vibe coding 场景下更关键 section) |
| Rationale: why mandatory marking | Task 2 (为什么必须是强制标记 section) |
| Rationale: consequences | Task 2 (没有这条规则的后果 section) |
| README: index table | Task 3 (Step 1) |
| README: badge update | Task 3 (Step 2) |
| README: quick-start block | Task 3 (Step 3) |
| README: structure tree | Task 3 (Step 4) |
| CLAUDE.md: Rules to Load table | Task 4 |
| Change log | Task 5 |
| Final verification | Task 6 |

All spec requirements covered.

### 2. Placeholder scan

No TBD, TODO, "implement later," or vague references. All rule and rationale content is written inline. All commit messages specified. All verification commands provided.

### 3. Type consistency

N/A — documentation-only change with no code types or function signatures.

No issues found.
