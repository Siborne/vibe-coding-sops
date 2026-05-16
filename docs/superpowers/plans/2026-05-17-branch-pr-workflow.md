# Branch & PR Workflow Rule — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add rule #8 (branch-pr-workflow) covering branch naming, PR scope, rebase strategy, pre-merge checklist, and merge/cleanup.

**Architecture:** One rule file + one rationale file + updates to README.md and CLAUDE.md indexes. No code, pure documentation following existing file format patterns.

**Tech Stack:** Markdown, git

---

### Task 1: Create rule file `rules/branch-pr-workflow.md`

**Files:**
- Create: `rules/branch-pr-workflow.md`

- [ ] **Step 1: Write the rule file**

```markdown
# 分支与 PR 工作流规则

每次开发必须遵循从分支创建到合并清理的完整工作流。不允许跳过任何环节。

## 1. 分支命名

格式: `<type>/<short-description>`

| type | 用途 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat/user-login` |
| `fix` | Bug 修复 | `fix/login-timeout` |
| `refactor` | 重构（不改行为） | `refactor/extract-auth` |
| `docs` | 文档变更 | `docs/api-guide` |
| `chore` | 杂项（依赖更新、配置） | `chore/update-deps` |
| `test` | 仅测试变更 | `test/add-login-spec` |

约束:
- description 用短横线分词，英文小写，不超过 4 个词
- 不包含用户名或工单号（除非团队有统一工单系统）

示例:
- ✅ `feat/oauth-github-integration`
- ✅ `fix/null-pointer-checkout`
- ❌ `siborne/feat/login` — 不必要时不加用户名
- ❌ `feature_login` — 无 type/ 前缀

## 2. PR 范围

核心原则: **一个 PR = 一个语义完整的变更。**

语义完整的判断标准:
- 能用一句话说清楚这个 PR 做了什么（说不清就是太大）
- 合并后 main 不会处于"半成品"状态（测试通过、功能可用）
- 不引入与 PR 目标无关的修改（不夹带重构、格式化）

规模参考（非硬性）:
- 典型 PR 在 200–800 行变更范围内
- 超过 2000 行时，作者应思考是否可以拆分
- 特殊情况（大规模重命名、自动生成代码）允许例外，在 PR 描述中说明

拆分技巧:
- 先提基础数据模型 PR → 再提业务逻辑 PR → 最后 UI/展示层 PR
- 重构前置：把纯重构拆为独立 PR，功能 PR 只包含行为变更

## 3. 分支同步策略

原则: **Rebase 优先，保持线性历史。**

日常同步（分支开发中）:
- `git fetch origin && git rebase origin/main` — 把 main 的新提交拉到分支底下
- 有冲突时本地解决，不要开 merge commit
- rebase 频率：至少每天一次，或者知道 main 有重大变更时立即同步

PR 合并前:
- 先 rebase 到最新 main，确保 CI 仍然通过
- 禁止 "Merge main into branch" 产生反向 merge commit

冲突处理:
- 冲突在本地解决，按功能语义取舍（不是无脑选自己的代码）
- 解决后跑一遍完整测试再 push
- force push 到自己的 feature 分支是允许的（且唯一允许 force push 的场景）

唯一例外:
- 多人协作者共享的分支，协商后再 rebase，避免其他人的 commit 丢失

## 4. 提交前检查清单

### A 层 — 自动化检查（必须通过）

- [ ] Lint 通过
- [ ] 测试全部通过
- [ ] 构建成功

### B 层 — 作者自查（提交 PR 前完成）

- [ ] 变更记录已创建（`docs/变更记录/` 下的文件已写好）
- [ ] Commit message 合规（详见提交信息规则）
- [ ] 已在本地自测过 happy path 和至少一个边界情况
- [ ] 没有遗留调试代码（console.log / print / TODO 标记）
- [ ] PR 描述写明了：做了什么、为什么这样做、有无风险

### C 层 — Review 门槛

- [ ] 至少一位协作者 review 通过（Approve）
- [ ] Reviewer 提出的 blocking 意见全部解决
- [ ] 如果 PR 在 review 后有新 push，需要 reviewer 重新确认

## 5. 合并与清理

合并权限:
- Reviewer 执行 merge（不是作者自己）
- Reviewer 确认 CI 在 rebase 后仍然绿色后再 merge

合并方式:
- 使用 fast-forward merge 或 rebase-merge（与 rebase 策略一致）
- 禁止 squash merge（会丢失分支内的提交粒度）
- 禁止创建 merge commit（`git merge --no-ff`），保持线性历史

合并后清理:
- 合并后立即删除远程分支
- 作者本地执行 `git fetch --prune` 清理远程分支引用
- 作者本地删除对应的本地分支

回头看:
- 如果合并后发现 bug，从 main 新开 `fix/` 分支，不走回头路在原分支上改

## 适用范围

所有项目的所有分支操作。无论单人开发还是团队协作，全部遵循本规则。
```

- [ ] **Step 2: Commit**

```bash
git add rules/branch-pr-workflow.md
git commit -m "$(cat <<'EOF'
feat: add branch-pr-workflow rule (#8)

Add rule covering full branch/PR lifecycle: naming convention (feat/fix/refactor/docs/chore/test),
PR scope (semantic completeness), rebase-first sync strategy, three-layer pre-merge checklist
(auto + self-check + review), and merge/cleanup procedures.
EOF
)"
```

---

### Task 2: Create rationale file `rationale/branch-pr-workflow.md`

**Files:**
- Create: `rationale/branch-pr-workflow.md`

- [ ] **Step 1: Write the rationale file**

```markdown
# 为什么需要分支与 PR 工作流规则

## 触发场景

一个团队刚开始用 AI 辅助编码。第一天，三个人的分支风格分别是 `login-fix`、`zhang/work`、`feat/login`。第三天，有人把 `main` merge 进了 feature 分支，产生了一串 "Merge branch 'main' into feat/xxx" 的提交。PR 开了，没有描述，没有自测记录，reviewer 不知道从何看起。合并后分支不删，一个月后 `git branch -r` 翻不到底。

## 核心问题

AI 不会替你管理 Git。它没有"这个分支命名对吗"、"现在该 rebase 了吗"、"PR 开之前自测过了吗"的自觉。人类如果没有一套明确规则，在 AI 高频产出的节奏下，Git 历史会迅速劣化——命名混乱、merge commit 泛滥、分支堆积、PR 无上下文。

## 为什么不能"靠经验"或"看情况"

- 分支命名靠经验 → 每个人经验不同，十个分支五种格式
- PR 大小靠感觉 → "感觉不大"但实际 3000 行，review 没人接
- 合并方式靠习惯 → 有人 rebase 有人 merge，历史图一团乱麻
- 检查清单靠记忆 → 总会忘一两个项

## 在 vibe coding 场景下更关键

AI 辅助编码让分支创建频率暴增——一个 session 可能开 3-5 个分支。如果没有统一的命名和清理规则：
- `git branch -a` 三周后有 80 个分支，没人知道哪个在用
- 合并方式随 AI 每次回复变化——一天 rebase 一天 merge
- PR 描述靠 AI 生成但无约束——有些详细到荒唐，有些一句 "fix"

## 没有这条规则的后果

- 分支命名混乱，无法从名称判断分支用途
- Git 历史图呈"地铁图"状，merge commit 比功能 commit 还多
- 分支长期不清理，远程仓库成为分支坟场
- PR 没有自检清单，reviewer 需要反复提醒基础问题
- 合并方式不统一，cherry-pick 和回滚时行为不可预测
```

- [ ] **Step 2: Commit**

```bash
git add rationale/branch-pr-workflow.md
git commit -m "$(cat <<'EOF'
docs: add rationale for branch-pr-workflow rule

Explain why unstructured branch/PR workflow degrades git history under
AI-assisted coding: naming chaos, merge commit proliferation, branch
accumulation, and PRs without context.
EOF
)"
```

---

### Task 3: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Update badge (rules-7 → rules-8)**

Line 5: Change `rules-7` to `rules-8`

```diff
-  <img src="https://img.shields.io/badge/rules-7-4caf50.svg" alt="Rules: 7">
+  <img src="https://img.shields.io/badge/rules-8-4caf50.svg" alt="Rules: 8">
```

- [ ] **Step 2: Add rule #8 to quick-start section**

After line 35 (`- 状态诚实规则: rules/status-honesty.md`), add:

```markdown
- 分支与 PR 工作流规则: rules/branch-pr-workflow.md
```

- [ ] **Step 3: Add rule #8 to the index table**

After line 48 (row for rule #7), add:

```markdown
| 8 | [分支与 PR 工作流规则](rules/branch-pr-workflow.md) | 完整分支/PR 生命周期：命名规范、PR 范围定义、rebase 策略、三层检查清单、合并与清理 |
```

- [ ] **Step 4: Add to repo structure**

After line 63 (`│   └── status-honesty.md` in rules section), add:

```
│   └── branch-pr-workflow.md
```

After line 71 (`│   └── status-honesty.md` in rationale section), add:

```
│   └── branch-pr-workflow.md
```

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "$(cat <<'EOF'
docs: add branch-pr-workflow rule (#8) to README index

Update badge, quick-start, index table, and repo structure.
EOF
)"
```

---

### Task 4: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Add rule #8 to Rules to Load table**

After line 30 (row for Status Honesty), add:

```markdown
| Branch & PR Workflow | `rules/branch-pr-workflow.md` | Full lifecycle: branch naming (feat/fix/refactor/docs/chore/test), PR scope (semantic completeness), rebase-first sync, 3-layer pre-merge checklist, reviewer merge + cleanup |
```

- [ ] **Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "$(cat <<'EOF'
docs: register branch-pr-workflow rule in CLAUDE.md Rules to Load
EOF
)"
```

---

### Task 5: Create change log

**Files:**
- Create: `docs/变更记录/新增分支PR工作流规则_2026-05-17.md`

- [ ] **Step 1: Write the change log**

```markdown
# 新增分支与 PR 工作流规则

## 基本信息
- **时间:** 2026-05-17
- **修改文件:**
  - `rules/branch-pr-workflow.md` (新增)
  - `rationale/branch-pr-workflow.md` (新增)
  - `README.md` (修改)
  - `CLAUDE.md` (修改)

## 根因分析

仓库缺少对分支/PR 工作流的约束规则。在 AI 辅助编码的高频分支创建场景下，
无规则会导致：命名混乱、merge commit 泛滥、分支堆积不清理、PR 无自检清单。

## 修改详情

### 文件: rules/branch-pr-workflow.md (新增)

新增规则 #8，覆盖 5 个环节：
1. 分支命名规范 — `<type>/<short-description>` 前缀式
2. PR 范围定义 — 语义完整，不硬性限制行数
3. 分支同步策略 — Rebase 优先，线性历史
4. 提交前检查清单 — A 层自动化 + B 层自检 + C 层 Review 门槛
5. 合并与清理 — Reviewer merge + 删除分支

### 文件: rationale/branch-pr-workflow.md (新增)

解释为什么需要此规则，聚焦 AI 辅助编码场景下的 Git 历史劣化问题。

### 文件: README.md (修改)

- 徽章 `rules-7` → `rules-8`
- 快速开始区新增规则引用
- 规则索引表新增 #8 行
- 仓库结构区新增两个文件

### 文件: CLAUDE.md (修改)

- Rules to Load 表新增 Branch & PR Workflow 行

## 解决方案

新增一条完整的分支/PR 工作流规则，约束从分支创建到合并清理的全生命周期，
确保 AI 辅助编码下的 Git 历史保持可读、可追溯、可维护。
```

- [ ] **Step 2: Commit**

```bash
git add docs/变更记录/新增分支PR工作流规则_2026-05-17.md
git commit -m "$(cat <<'EOF'
docs: add change log for branch-pr-workflow rule addition
EOF
)"
```
