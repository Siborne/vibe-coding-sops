# Status Honesty Rule — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add rule #7 "Status Honesty" to the vibe-coding-sops rule collection — AI must honestly report completion status with one of four states, never claiming DONE without verification evidence.

**Architecture:** Two new files (`rules/status-honesty.md`, `rationale/status-honesty.md`) plus updates to two index files (`README.md`, `CLAUDE.md`) and a change log per this repo's self-application rule. All rule/rationale content in Chinese to match existing convention.

**Tech Stack:** Markdown only. No code, no dependencies.

---

### File Structure

```
Create:
  rules/status-honesty.md           # The rule: what to do, how, with examples
  rationale/status-honesty.md       # The rationale: why this rule exists
  docs/变更记录/status-honesty规则新增_2026-05-17.md  # Change log per repo self-application rule

Modify:
  README.md                         # Add rule #7 to index table, bump badge to rules-7
  CLAUDE.md                         # Add to Rules to Load table
```

---

### Task 1: Create the Rule File

**Files:**
- Create: `rules/status-honesty.md`

- [ ] **Step 1: Write the rule file**

```markdown
# 状态诚实规则

AI 在报告任务完成状态时必须诚实，区分"代码写完了"和"验证通过了"，不允许夸大成"做完了"。

## 四种状态

每次代码修改后，必须在回复末尾附上状态块，使用以下四种状态之一：

| 状态 | 含义 |
|------|------|
| `DONE` | 实现 + 验证 + 测试全部完成 |
| `PENDING VERIFICATION` | 代码已写但未验证、未跑测试 |
| `BLOCKED` | 遇到无法自行解决的问题，需要人工介入 |
| `PARTIAL` | 完成了部分任务，其余尚未开始 |

## 状态块格式

每轮产生代码修改的回复，末尾必须附带如下状态块：

```
---
Status: PENDING VERIFICATION
Done: 已改 rules/status-honesty.md, 新建 rationale/status-honesty.md
Not done: 尚未更新 README.md 和 CLAUDE.md
Next: git diff 确认改动正确
```

### 各字段说明

- **Status**: 四种状态之一，必填
- **Done**: 本轮已完成的具体事项（改了什么文件、做了什么操作）
- **Not done**: 尚未完成但计划要做的部分
- **Next**: 下一步动作

## DONE 必须附带验证清单

声称 `DONE` 时，不能只写结论。必须列出验证证据，展示每个验证项的完成情况：

```
---
Status: DONE
Done: 新增规则文件、原因文件、更新 README、更新 CLAUDE.md
Verification:
[x] 规则文件已创建且内容完整
[x] 原因文件已创建
[x] README.md 已加入第 7 条规则
[x] CLAUDE.md Rules to Load 表格已更新
[x] git diff 只显示预期改动
```

**如果无法提供验证清单，状态不能是 DONE。**

## 用户反馈处理

用户指出"不 work / 有问题 / 没做完"时，AI 必须：

1. 不辩解、不重复使用同样的错误方案（除非能解释为什么这次不同）
2. 第一步：复现问题
3. 第二步：确认根因
4. 第三步：实施修复
5. 状态降级为 `BLOCKED` 或 `PENDING VERIFICATION`

## 适用范围

**适用场景：**
- 所有产生代码修改的任务（Bug 修复、新功能、重构、文档编写）
- 涉及代码变更的多轮对话

**不适用场景：**
- 纯问答/信息查询，无代码产出
- 用户明确说"不用跟状态块"

## 边界情况

| 场景 | 要求 |
|------|------|
| AI 不确定是否真正完成 | 默认使用 `PENDING VERIFICATION`，宁保守不夸大 |
| 用户中途改变方向 | 报告 `PARTIAL`，列明哪些已完成、哪些已废弃 |
| 会话结束但任务未完成 | 以 `PARTIAL` 结束，给出具体下一步建议 |
| AI 写错了、用户指出 | 状态降级为 `BLOCKED` 或 `PENDING VERIFICATION`，不复用旧方案 |
```

- [ ] **Step 2: Verify the file was created**

```bash
ls -la "S:/Sto-box/700-project/vibe-coding-sops/rules/status-honesty.md"
```

Expected: file exists, non-zero size.

- [ ] **Step 3: Commit**

```bash
git add rules/status-honesty.md
git commit -m "$(cat <<'EOF'
add rule #7: Status Honesty — AI must report honest completion status

Four required states (DONE / PENDING VERIFICATION / BLOCKED / PARTIAL).
DONE requires verification checklist, not just assertion.
User feedback triggers status downgrade and reproduction-before-fix.
EOF
)"
```

---

### Task 2: Create the Rationale File

**Files:**
- Create: `rationale/status-honesty.md`

- [ ] **Step 1: Write the rationale file**

```markdown
# 为什么需要状态诚实

## 触发场景

AI 写了 3 个文件，声称"做完了"。用户尝试运行 — 其中一个文件调用了一个不存在的 API 函数，另一个悄悄吞掉了错误。AI 那句"做完了"让用户放心地翻篇了，两周后 bug 在线上被发现。

## 核心问题

AI 把"代码写出来了"等同于"任务完成了"。但没验证过的代码只是草稿。没有显式的状态报告，用户无法区分"我写了"和"我确认它能用"。

## 为什么在 vibe coding 场景下更关键

手写代码有自然检查点：写完 → 编译 → 运行 → 看结果。AI 辅助编码把这些压缩到了秒级。速度让人跳过验证——AI 和用户都感觉效率很高，但产出并未真正验证。

具体到"假完成"的危害：

- **信任侵蚀**：被 AI 骗过两次"做完了"，用户会习惯性怀疑所有回复，反而浪费更多时间逐条确认
- **上下文丢失**：当用户以为"A 功能做完了"并开始布置 B 功能时，A 功能的未完成状态就被永久埋进了代码里——因为后续对话已经切换到 B 的话题了
- **多轮放大**：一轮的假完成在下一轮被当成"已完成的基础"，在新代码中复用这个未验证的旧代码，错误层叠

## 为什么必须是结构化状态块而非靠 AI 自觉

- **可强制执行**：状态块是显式要求，不是暗示。缺少状态块一眼就能看出来
- **可审计**：回顾对话时，每轮的状态块提供了清晰的"进度快照"
- **四种状态覆盖全貌**：DONE / PENDING VERIFICATION / BLOCKED / PARTIAL 四种状态互不重叠，没有模糊地带
- **验证清单防止空口无凭**：DONE 状态强制附带证据，AI 不能只凭感觉说"做完了"

## 没有这条规则的后果

- AI 声称 DONE 但代码跑不通，用户需要逐次验证所有 AI 输出
- "假完成" 的代码进入生产环境，线上故障追溯到未完成的 AI 代码
- 团队速度幻觉：一堆 DONE 的任务实际上没有一个真正完成
- 更隐蔽的是：后续代码基于"已完成"但实际未完成的代码编写，错误扩散
```

- [ ] **Step 2: Verify the file was created**

```bash
ls -la "S:/Sto-box/700-project/vibe-coding-sops/rationale/status-honesty.md"
```

Expected: file exists, non-zero size.

- [ ] **Step 3: Commit**

```bash
git add rationale/status-honesty.md
git commit -m "$(cat <<'EOF'
add rationale for rule #7: why Status Honesty matters

Explains the fake-completion problem in vibe coding, why structural
status blocks work better than trusting AI self-discipline, and the
compounding damage of unverified code propagating through sessions.
EOF
)"
```

---

### Task 3: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Add rule #7 to the index table**

Read `README.md` and find the index table (the markdown table under `## 规则索引`). Add a new row after rule #6:

```markdown
| 7 | [状态诚实规则](rules/status-honesty.md) | AI 每次回复必须附状态块，四种状态（DONE/PENDING VERIFICATION/BLOCKED/PARTIAL），DONE 必须附带验证清单 |
```

The existing rows up to #6 are:
```markdown
| # | 规则 | 说明 |
|---|------|------|
| 1 | [代码变更记录规则](rules/code-change-log.md) | 每次修改必须创建结构化变更记录，含根因分析 + 修改前后对比 |
| 2 | [有意义注释规则](rules/meaningful-comments.md) | 七类值得写的注释：TODO / 参考资料 / 正确性说明 / 血泪教训 / 常数理由 / 承重细节 / 为什么不用 X |
| 3 | [README 编写规则](rules/readme-structure.md) | 漏斗式组织，依次回答：做什么 → 为什么在乎 → 怎么用 → 怎么装 |
| 4 | [提交信息规则](rules/commit-message.md) | 提交信息是 git 的历史记录，应回答：问题、方案对比、取舍、意外点 |
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则：对事不对人、可操作建议、提问、解释为什么、区分阻断、肯定优点、适可而止 |
| 6 | [代码风格声明规则](rules/code-style-declaration.md) | 开发前必须声明风格基准、决策偏好、禁止项；不允许没有风格声明就开始写代码 |
```

Append row 7 after row 6.

- [ ] **Step 2: Update the badge from rules-6 to rules-7**

The badge line currently reads:
```
<img src="https://img.shields.io/badge/rules-6-4caf50.svg" alt="Rules: 6">
```
Change it to:
```
<img src="https://img.shields.io/badge/rules-7-4caf50.svg" alt="Rules: 7">
```

- [ ] **Step 3: Update the quick-start code block to include rule #7**

The quick-start block under `## 快速开始` lists 5 referenced rules. Add the new rule reference after the code-review line:

Current block:
```
# 在你的项目 CLAUDE.md 中引用
本项目遵循 vibe-coding-sops 中的规则，详见：
- 代码变更记录规则: rules/code-change-log.md
- 有意义注释规则: rules/meaningful-comments.md
- README 编写规则: rules/readme-structure.md
- 提交信息规则: rules/commit-message.md
- 代码评审规则: rules/code-review.md
```

Updated block:
```
# 在你的项目 CLAUDE.md 中引用
本项目遵循 vibe-coding-sops 中的规则，详见：
- 代码变更记录规则: rules/code-change-log.md
- 有意义注释规则: rules/meaningful-comments.md
- README 编写规则: rules/readme-structure.md
- 提交信息规则: rules/commit-message.md
- 代码评审规则: rules/code-review.md
- 状态诚实规则: rules/status-honesty.md
```

- [ ] **Step 4: Update the repository structure tree to include the new files**

The tree under `## 仓库结构` shows the rules/ and rationale/ directories with existing files. Add `status-honesty.md` to both:

In `rules/` section, after `code-style-declaration.md`:
```
│   └── status-honesty.md
```
In `rationale/` section, after `code-style-declaration.md`:
```
│   └── status-honesty.md
```

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "$(cat <<'EOF'
add rule #7 Status Honesty to README index, badge, and structure tree
EOF
)"
```

---

### Task 4: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Add rule #7 to the Rules to Load table**

Find the table under `## Rules to Load`. Add a new row after the Code Style Declaration row:

```markdown
| Status Honesty | `rules/status-honesty.md` | After every code change, report one of four statuses (DONE/PENDING VERIFICATION/BLOCKED/PARTIAL); DONE requires verification checklist |
```

The full table after the edit:
```markdown
| Rule | File | Core Requirement |
|------|------|-----------------|
| Code Change Log | `rules/code-change-log.md` | After every Edit/Write, create a change log in `docs/变更记录/` with root cause analysis and before/after code |
| Meaningful Comments | `rules/meaningful-comments.md` | Comments explain WHY not WHAT; 7 types: TODO, references, correctness, lessons learned, constants, load-bearing details, "why not X" |
| README Structure | `rules/readme-structure.md` | Funnel: what → why care → how to use → how to install; show usage before install steps |
| Commit Messages | `rules/commit-message.md` | Commit body answers: what problem, alternatives considered, tradeoffs, surprises |
| Code Review | `rules/code-review.md` | Review code not people; actionable suggestions; ask don't command; explain why; label blocking vs suggestion; praise good work; know when to stop |
| Code Style Declaration | `rules/code-style-declaration.md` | Before writing any code, declare: style guide, preference decisions (if-else vs strategy, immutability), forbidden patterns |
| Status Honesty | `rules/status-honesty.md` | After every code change, report one of four statuses (DONE/PENDING VERIFICATION/BLOCKED/PARTIAL); DONE requires verification checklist |
```

- [ ] **Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "$(cat <<'EOF'
add rule #7 Status Honesty to CLAUDE.md Rules to Load table
EOF
)"
```

---

### Task 5: Create Change Log

**Files:**
- Create: `docs/变更记录/status-honesty规则新增_2026-05-17.md`

This is required by the repo's self-application rule in CLAUDE.md: every modification to this repo must have a change log.

- [ ] **Step 1: Write the change log**

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
git add docs/变更记录/status-honesty规则新增_2026-05-17.md
git commit -m "$(cat <<'EOF'
add change log for rule #7 Status Honesty addition
EOF
)"
```

---

### Task 6: Final Verification

- [ ] **Step 1: Verify all files are committed and working tree is clean**

```bash
git status
```

Expected: `nothing to commit, working tree clean`

- [ ] **Step 2: Verify file structure matches README**

```bash
ls -1 rules/ && echo "---" && ls -1 rationale/
```

Expected: 7 files in each directory, including `status-honesty.md`

- [ ] **Step 3: Verify CLAUDE.md Rules to Load table has 7 entries**

```bash
grep -c "rules/" CLAUDE.md
```

Expected: 7 (or equivalent showing all 7 rules are listed)
```

---

## Plan Self-Review

### 1. Spec coverage

| Spec requirement | Covered by |
|-----------------|------------|
| Four statuses defined | Task 1 (rule file, 四种状态 section) |
| Status block format | Task 1 (状态块格式 section) |
| DONE requires verification checklist | Task 1 (DONE 必须附带验证清单 section) |
| User feedback handling | Task 1 (用户反馈处理 section) |
| Scope: applies to code-change tasks | Task 1 (适用范围 section) |
| Scope: does NOT apply to pure Q&A | Task 1 (适用范围 section) |
| Edge cases table | Task 1 (边界情况 section) |
| Rationale with trigger scenario | Task 2 (触发场景, 核心问题 sections) |
| Why matters more in vibe coding | Task 2 (为什么在 vibe coding 场景下更关键 section) |
| Consequences without the rule | Task 2 (没有这条规则的后果 section) |
| README update | Task 3 (index, badge, quick-start, structure tree) |
| CLAUDE.md update | Task 4 (Rules to Load table) |
| Change log | Task 5 (per repo self-application rule) |
| Split from "uncertainty marking" rule | Task 5 change log (设计决策 section) |

All spec requirements covered.

### 2. Placeholder scan

No TBD, TODO, "implement later," or vague references. All code/content is written inline.

### 3. Type consistency

N/A — this is a documentation-only change with no code types.

No issues found.
