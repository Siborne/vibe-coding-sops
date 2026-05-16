# i18n: English-first Rules with Bilingual Rationale — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert all 6 rules to English (AI-facing), enhance all 6 Chinese rationale files with AI-specific risk sections, and create independent English rationale versions.

**Architecture:** Three sequential layers. Layer 1 moves existing Chinese rationale to `rationale/zh/` and expands the vibe-coding section into an AI-specific risk analysis. Layer 2 rewrites all rule files in English with RFC 2119 instructional tone. Layer 3 writes English rationale files independently (not translations). Side effects: update CLAUDE.md and README.md.

**Tech Stack:** Markdown files only. No dependencies, no build step.

---

## File Map

| File | Action | Layer |
|------|--------|-------|
| `rationale/zh/code-change-log.md` | Move + enhance | 1 |
| `rationale/zh/meaningful-comments.md` | Move + enhance | 1 |
| `rationale/zh/readme-structure.md` | Move + enhance | 1 |
| `rationale/zh/commit-message.md` | Move + enhance | 1 |
| `rationale/zh/code-review.md` | Move + enhance | 1 |
| `rationale/zh/code-style-declaration.md` | Move + enhance | 1 |
| `rules/code-change-log.md` | Rewrite (EN) | 2 |
| `rules/meaningful-comments.md` | Rewrite (EN) | 2 |
| `rules/readme-structure.md` | Rewrite (EN) | 2 |
| `rules/commit-message.md` | Rewrite (EN) | 2 |
| `rules/code-review.md` | Rewrite (EN) | 2 |
| `rules/code-style-declaration.md` | Rewrite (EN) | 2 |
| `rationale/code-change-log.md` | Rewrite (EN) | 3 |
| `rationale/meaningful-comments.md` | Rewrite (EN) | 3 |
| `rationale/readme-structure.md` | Rewrite (EN) | 3 |
| `rationale/commit-message.md` | Rewrite (EN) | 3 |
| `rationale/code-review.md` | Rewrite (EN) | 3 |
| `rationale/code-style-declaration.md` | Rewrite (EN) | 3 |
| `CLAUDE.md` | Update table | Side |
| `README.md` | Add lang badges, bilingual index | Side |

---

## Layer 1: Chinese Rationale Enhancement

Each task: move existing file to `rationale/zh/`, then expand the "在 vibe coding 场景下更关键" section into "AI 辅助编码的特殊风险".

### Task 1: Move + enhance rationale/zh/code-change-log.md

**Files:**
- Create: `rationale/zh/code-change-log.md`
- Delete: `rationale/code-change-log.md` (moved, will be recreated in Layer 3)

- [ ] **Step 1: Create rationale/zh/ directory and move file**

```bash
mkdir -p rationale/zh
git mv rationale/code-change-log.md rationale/zh/code-change-log.md
```

- [ ] **Step 2: Replace the vibe-coding section with expanded AI-specific risk section**

Replace:
```
## 在 vibe coding 场景下更关键

AI 辅助编码的产出速度远超手写，一天可能产生几十处修改。这些修改的质量参差不齐——有的经过深思熟虑，有的是一次性试出来的。如果不记录，两周后连你自己都分不清哪些修改是有意为之、哪些只是 prompt 的副作用。
```

With:
```markdown
## AI 辅助编码的特殊风险

AI 辅助编码一天可以产生几十处修改，但 AI 不会主动告诉你它改了哪里、为什么改。具体来说：

**AI 倾向于"静默修改"。** 当你让 AI "修复这个 bug"，它可能同时调整了三个相关文件的逻辑——但只告诉你修了 bug。那些连带修改如果没有被记录，两周后你根本无法从 git diff 中区分哪些是 bug fix 的主体、哪些是 AI 顺手改的。更糟的是，AI 的"顺手改"有时是对的（清理了遗留问题），有时是错的（误解了相关代码的意图），不记录就等于放弃了判断机会。

**AI 的修改缺乏"人脑 git blame"。** 手写代码时，你记得自己大概改了什么、为什么改——你的大脑里有一份非正式的变更日志。AI 辅助时，你变成了 reviewer 而非 author，你没有"我写这段时在想什么"的记忆。结构化变更记录替代了这份缺失的记忆。

**Prompt 迭代是隐式的。** 一个功能可能经历了 5 轮 prompt 调整才定型，中间尝试过 3 种方案。如果不记录最终方案为什么胜出，接手者（或三个月后的你）看到代码时会想"这里为什么不用更简单的 X 方案"——然后花半天时间尝试 X，发现它确实不行，而这本该是变更记录里一句话就能挡住的事。

简单说：手写代码时，变更记录是锦上添花；AI 辅助编码时，变更是你唯一能还原上下文的线索。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/code-change-log.md rationale/code-change-log.md
git commit -m "$(cat <<'EOF'
i18n(L1): move code-change-log rationale to zh/ and expand AI risk section
EOF
)"
```

### Task 2: Enhance rationale/zh/meaningful-comments.md

**Files:**
- Create: `rationale/zh/meaningful-comments.md`
- Delete: `rationale/meaningful-comments.md` (moved)

- [ ] **Step 1: Move file**

```bash
git mv rationale/meaningful-comments.md rationale/zh/meaningful-comments.md
```

- [ ] **Step 2: Replace the vibe-coding section**

Replace:
```
## 在 vibe coding 场景下更关键

AI 生成的代码往往"看起来很对"——逻辑通顺、命名规范、没有语法错误。但它会：
- 选择次优方案（因为训练数据偏向常见模式）
- 忽略项目特有的约束（因为不了解完整上下文）
- 制造看似合理的常数（实际上需要根据环境调整）

这些 AI 代码的"隐性瑕疵"必须通过注释暴露出来，否则过段时间谁都看不出来。
```

With:
```markdown
## AI 辅助编码的特殊风险

AI 生成的代码有一个危险的特性：**看起来总是对的。** 逻辑通顺、命名规范、格式化完美——正是这种"表面正确"让问题更难被发现。

**AI 最擅长写废话注释。** 训练数据中充斥着 `// validate input`、`// increment counter` 这类翻译代码的注释，AI 学会了"每段代码配注释"的形式，但没学会注释应该填补代码无法表达的信息。如果不加约束，AI 产出的注释一半以上是噪音，真正的 WHY 反而没写。这条规则的七类注释分类，本质上是给 AI 一个过滤器：如果你的注释不属于这七类，别写。

**AI 的常数是"合理的幻觉"。** 当你问 AI "这里超时设多少"，它可能输出 `TIMEOUT = 30`——30 是从某段训练数据里抄来的，不是根据你的环境算的。如果注释规则要求常数的理由必须写，`TIMEOUT = 30  # AI建议值，未经实测` 这条注释就能救命——后来者看到就知道要验证，而不是盲信。

**AI 缺乏"被坑过"的记忆。** 一个 bug 你可能花了两小时调试才修好，AI 帮你写了修复代码——但它不知道你这两小时的痛苦。如果不在注释里记录"为什么这样修"（血泪教训类注释），下次重构时这段修复可能被当成多余代码删掉，bug 回归。

**AI 会触发"为什么不用 X"问题到极致。** AI 选择方案时基于统计频率而非项目特殊性。它可能在 10 个项目中选了 10 种不同的 JSON 解析方式，每次都是合理的——但放在同一个项目里就是灾难。当你刻意避开 AI 建议的"标准做法"时，必须注释为什么，否则下一个接手者（或下一个 AI session）会把标准做法"修复"回来。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/meaningful-comments.md rationale/meaningful-comments.md
git commit -m "$(cat <<'EOF'
i18n(L1): move meaningful-comments rationale to zh/ and expand AI risk section
EOF
)"
```

### Task 3: Enhance rationale/zh/readme-structure.md

**Files:**
- Create: `rationale/zh/readme-structure.md`
- Delete: `rationale/readme-structure.md` (moved)

- [ ] **Step 1: Move file**

```bash
git mv rationale/readme-structure.md rationale/zh/readme-structure.md
```

- [ ] **Step 2: Replace the vibe-coding section**

Replace:
```
## 在 vibe coding 场景下更关键

AI 辅助项目通常产出快、迭代多。README 是你项目对外部的唯一发言人。如果 README 是反漏斗的，即使代码写得再好，也没人知道它存在。
```

With:
```markdown
## AI 辅助编码的特殊风险

AI 辅助项目产出快、迭代多——但 README 常常被遗忘，因为 AI 不会主动帮你维护它。

**AI 写 README 的默认模式是反漏斗的。** 训练数据中大量 README 开篇就是安装步骤，AI 看到"帮我写个 README"时，倾向于生成"安装 → 配置 → API"的结构——因为它见过的 README 大部分就是这样写的。你不明确要求漏斗式结构，AI 就不会漏斗式。这条规则把正确的结构写死，AI 才能遵循。

**代码和 README 的同步是单向失联。** AI 帮你加了一个核心功能、改了两个 API 端点——它更新了代码，但不会主动更新 README。三个月后，README 描述的功能和实际代码已经对不上。这种"代码正确但 README 过时"的状态比没有 README 更危险：它会误导新用户按错误文档操作，然后困惑为什么行不通。

**AI 生成的内容缺乏叙事。** AI 可以列出所有 API 端点，但它无法判断"新用户最需要先看到什么"。漏斗结构的价值恰好在于人工编排的叙事顺序——你得告诉 AI 按什么顺序组织信息，而不是让它吐出一份 API 参考文档。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/readme-structure.md rationale/readme-structure.md
git commit -m "$(cat <<'EOF'
i18n(L1): move readme-structure rationale to zh/ and expand AI risk section
EOF
)"
```

### Task 4: Enhance rationale/zh/commit-message.md

**Files:**
- Create: `rationale/zh/commit-message.md`
- Delete: `rationale/commit-message.md` (moved)

- [ ] **Step 1: Move file**

```bash
git mv rationale/commit-message.md rationale/zh/commit-message.md
```

- [ ] **Step 2: Replace the vibe-coding section**

Replace:
```
## 在 vibe coding 场景下更关键

AI 辅助编码产生的提交频率远高手写。一天几十个 commit 不稀奇。如果每个 commit 都是 "update"、"fix"，三天后的 `git log` 就是一本无字天书。你需要通过提交信息快速定位"哪个 commit 引入了哪个变更"。
```

With:
```markdown
## AI 辅助编码的特殊风险

AI 辅助编码让提交频率暴涨——以前一天 3-5 个 commit，现在可能是 20-30 个。频率越高，提交信息质量越重要。

**AI 生成的默认提交信息是垃圾。** 如果你让 AI 帮你写 commit message 而不给规则，它会生成 "fix bug"、"update code"、"refactor" 这类信息——它没有你修改上下文的内存，只能根据 diff 猜个大概。你需要给它一个明确的模板（四个问题），它才能产出有用的提交信息。

**批量提交让追溯更困难。** 手写代码时，每个 commit 对应一个清晰的决策时刻。AI 辅助时，你可能在半小时内改了 5 个文件、3 个不同功能点，然后一次性提交。如果提交信息不把每个决策点说清楚，`git blame` 追到的就是一个巨大的混合 commit，什么也分不出来。

**"为什么"比"改了什么"更需要记录。** AI 可以生成完美的 diff 描述——它能看到改了哪些行。但为什么选方案 B 不选方案 A、为什么避免某个看似更优的写法——这些 AI 不知道，只有你知道。而恰恰是这些信息，在三个月后排查问题时最稀缺。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/commit-message.md rationale/commit-message.md
git commit -m "$(cat <<'EOF'
i18n(L1): move commit-message rationale to zh/ and expand AI risk section
EOF
)"
```

### Task 5: Enhance rationale/zh/code-review.md

**Files:**
- Create: `rationale/zh/code-review.md`
- Delete: `rationale/code-review.md` (moved)

- [ ] **Step 1: Move file**

```bash
git mv rationale/code-review.md rationale/zh/code-review.md
```

- [ ] **Step 2: Replace the vibe-coding section**

Replace:
```
## 在 vibe coding 场景下更关键

AI 产出的代码有其特征：逻辑上通顺、格式化完美、但可能在边界条件、安全、并发、资源泄漏等方面存在隐患。代码评审是发现这些隐患的关卡——不是不信任 AI，而是 AI 生成速度太快，人工审查必须跟紧。
```

With:
```markdown
## AI 辅助编码的特殊风险

AI 生成代码的速度远超人工审查的速度。这创造了一个不对称：AI 可以在 30 秒内产出 200 行代码，而认真审查 200 行代码可能需要 20 分钟。如果不建立评审纪律，AI 产出速度会压倒审查能力。

**AI 代码的 bug 分布和人不一样。** 人类容易在复杂逻辑处出错；AI 容易在边界条件、并发安全、资源释放、错误处理路径上留下隐患——这些地方对 AI 来说是"低频路径"，训练数据中示例少。更麻烦的是，AI 代码在正常路径上通常没问题，给人一种"看起来很对"的安全感，降低了审查警觉性。

**AI 会在不同 session 中写出不同风格的代码。** 这是代码评审规则特别强调"模式收敛"的原因。没有评审，同一个功能可能被 AI 用三种不同风格实现三次——因为每次 AI 调用的偏好分布不同。评审是让这些发散风格重新收敛的机制。

**AI 会让知识分散问题恶化。** 人类作者至少对代码有所有权和记忆。AI 辅助时，你是 prompt 的作者但不是代码的作者——你可能不理解 AI 生成的每一行，也不记得它为什么选择了某个特定实现。如果这代码不经评审直接合入，那就是双倍的黑盒：连作者都不完全理解的黑盒。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/code-review.md rationale/code-review.md
git commit -m "$(cat <<'EOF'
i18n(L1): move code-review rationale to zh/ and expand AI risk section
EOF
)"
```

### Task 6: Enhance rationale/zh/code-style-declaration.md

**Files:**
- Create: `rationale/zh/code-style-declaration.md`
- Delete: `rationale/code-style-declaration.md` (moved)

- [ ] **Step 1: Move file**

```bash
git mv rationale/code-style-declaration.md rationale/zh/code-style-declaration.md
```

- [ ] **Step 2: Replace the vibe-coding section**

Replace:
```
## 在 vibe coding 场景下更关键

手写代码时，一个人的代码风格自然一致——因为只有一个脑子。AI 辅助编码时，"作者"切换了无数次——每次 AI 的回复都可能来自不同的风格区域。风格声明本质上是一个全局约束，把"每次回复"变成"所有回复"统一到一个标准下。
```

With:
```markdown
## AI 辅助编码的特殊风险

手写代码时，一个人的代码风格自然一致——因为只有一个大脑、一双手。AI 辅助编码时，你面对的是无数个"虚拟作者"：每次 AI 回复都可能来自其训练数据中不同的风格区域，你问两次同一个问题，可能拿到两种不同风格的代码。

**AI 的风格随机性是系统性的。** 这不是某个 AI 模型的缺陷，而是所有大语言模型的固有特征：训练数据覆盖所有风格，模型学会了所有风格，在没有约束的情况下随机采样。一个 500 行的文件，如果分 5 次让 AI 生成不同部分，可能出现 3 种缩进风格、2 种错误处理模式、4 种命名惯例。风格声明是这个随机性的"全局锁"。

**禁止项必须显式声明，AI 不会自己学到。** 你的项目禁用了 Lombok `@Data`，但 AI 不知道——它只看到你的代码里有 `@Getter` 和 `@Setter`，于是推断"这个项目用 Lombok"，然后在下一段代码里帮你加上 `@Data`。禁止项是你欠 AI 的一份说明：哪些常见做法在本项目里是被禁用的，以及为什么。

**即使有存量代码，AI 也未必能正确推断风格。** 存量代码可能本身风格就不一致（还没做声明的时候写的），有些偏好是策略层面的（"超过 3 个分支用策略模式"），从代码中无法直接推断——你只能看到现有的 if-else，看不到那条"超过 3 个就该切换"的规则。风格声明补齐了这个信息差。
```

- [ ] **Step 3: Commit**

```bash
git add rationale/zh/code-style-declaration.md rationale/code-style-declaration.md
git commit -m "$(cat <<'EOF'
i18n(L1): move code-style-declaration rationale to zh/ and expand AI risk section
EOF
)"
```

---

## Layer 2: English Rules Rewrite

Each task: write the English rule file based on the Chinese original, following the spec: TL;DR first line, RFC 2119 keywords, instructional tone, shorter than Chinese version.

### Task 7: Write rules/code-change-log.md (EN)

**Files:**
- Create: `rules/code-change-log.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# Code Change Log Rule

**Rule:** After every code change via Edit or Write, you MUST create a structured change log in `docs/变更记录/`.

## File Naming

`<brief-description>_<YYYY-MM-DD>.md`, e.g. `fix-pjax-loading-spinner_2026-05-11.md`

## Required Sections

### Basic Info
- **Timestamp**
- **Files modified**: list all file paths touched

### Root Cause Analysis
- What was the symptom?
- Why did it happen (technical root cause)?

### Change Details
For each changed location:
- File path + line range
- **BEFORE** and **AFTER** code comparison
- What this change fixes and why

### Solution
- Summary of the fix approach

## Code Diff Format

    ### File: layouts/partials/footer/custom.html (L10-L15)

    **BEFORE:**
    ```js
    // old code
    ```

    **AFTER:**
    ```js
    // new code
    ```

    > Why this change was made and what it accomplishes

## Scope

All code modifications via Edit or Write tools.
```

- [ ] **Step 2: Commit**

```bash
git add rules/code-change-log.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite code-change-log rule in English
EOF
)"
```

### Task 8: Write rules/meaningful-comments.md (EN)

**Files:**
- Create: `rules/meaningful-comments.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# Meaningful Comments Rule

**Rule:** Comments MUST explain WHY, not WHAT. If a comment doesn't fit one of the seven types below, delete it.

## The Seven Comment Types

### 1. TODO

Mark incomplete work. MUST include enough context for the next person to know what's missing and why it was deferred.

```python
# BAD
# TODO: optimize
for item in items:
    for other in items:
        compare(item, other)

# GOOD
# TODO: This O(n²) comparison is fine for n<100 (current max dataset ~60).
# If data scales up, switch to a spatial index (R-tree or geohash).
# See Notion design doc §3.
for item in items:
    for other in items:
        compare(item, other)
```

### 2. References

When implementing a paper algorithm, porting external code, or following documented behavior, link to the source. Use permanent URLs. Note any deviations from the reference.

```python
# Based on "Fast Polygon Triangulation" (Narkhede & Manocha, 1995)
# https://www.cs.unc.edu/~dm/CODE/GEM/chapter.html
# Deviation: the original assumes CCW vertex order; our input is CW,
# so the orientation() sign check is flipped at L45.
def triangulate(polygon):
    ...
```

### 3. Correctness Justification

Explain WHY unusual-looking code is actually correct. The code shows the steps; the comment explains why the steps work.

```python
# This looks like a double subtraction, but fee_ratio is already the
# net ratio (1 - tax_rate), so price * fee_ratio directly gives the
# take-home amount. No second subtraction needed.
net_amount = price * fee_ratio
```

### 4. Lessons Learned

If a fix took 30+ minutes to debug and the fix isn't obvious, record it. Past-you didn't know this was necessary; future readers won't either.

```python
# CRITICAL: Set Content-Type BEFORE starting streaming writes, or HTTP/2
# causes Flask to defer flush and the client misses the first chunk.
# Debug trail: client always missing first frame → packet capture showed
# push_promise sent AFTER data frame → Flask's send_header() skipped in
# streaming mode. Fix: explicitly set headers before first yield.
response.headers.add("Content-Type", "text/event-stream")
response.headers.add("X-Accel-Buffering", "no")
```

### 5. Magic Constant Rationale

Every non-obvious constant needs a reason. "It just worked when I tried 3" is valid information — it tells the reader this value wasn't derived and may need tuning.

```python
# 3s: AWS ALB default idle timeout is 60s; pinging every 20s is enough.
# Chose 3s (not 20s) because some enterprise proxies drop at 10s.
# Conservative, and the cost is negligible.
HEARTBEAT_INTERVAL = 3

# 16-bit: CRC-16 has >99.99% error detection for frames under 200 bytes.
# CRC-32 would add 2 bytes per frame — significant for 60-byte typical frames.
CRC_WIDTH = 16
```

### 6. Load-Bearing Details

If correctness depends on a seemingly trivial implementation detail, call it out. Otherwise refactoring will silently break it.

```python
# MUST be BTreeSet, not HashSet — the iteration below relies on
# lexicographic order to merge adjacent intervals in O(n), not O(n²).
# Someone changed this to HashSet in 2023 "because lookup is faster";
# 10k-interval merge went from 50ms to 3s. See issue #4221.
occupied: BTreeSet<Range>
```

### 7. "Why Not X"

When you deliberately avoid the obvious solution, explain why. Otherwise someone will "fix" it later and break things.

```python
# NOT using Django ORM's bulk_create() here because it doesn't fire
# post_save signals, and we need the signal to sync Elasticsearch.
# The per-row save() loop looks slow but the batch is <200 items
# and this runs in a background task.
for obj in items:
    obj.save()
```
```

- [ ] **Step 2: Commit**

```bash
git add rules/meaningful-comments.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite meaningful-comments rule in English
EOF
)"
```

### Task 9: Write rules/readme-structure.md (EN)

**Files:**
- Create: `rules/readme-structure.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# README Structure Rule

**Rule:** READMEs MUST follow funnel order: what it does → why care → how to use → how to install. Show usage before installation steps.

## The Funnel

Answer four questions in order, top to bottom:

1. **What does it do?** — One sentence + optional visual (screenshot, GIF, diagram)
2. **Why should I care?** — Core value proposition, what pain it solves
3. **How do I use it?** — Show usage first; let people see what they'll get
4. **How do I install it?** — Installation LAST, after the reader has decided to commit

> People want to see what they'll get before investing in setup steps.

## Good Example

```markdown
# lazydocker

Terminal UI for Docker, built with Go and gocui.

<p align="center">
  <img src="demo.gif" width="600">
</p>

## Why lazydocker

Managing Docker from the terminal usually means `docker` + `docker-compose`
plus manually typing container names. lazydocker gives you a single TUI panel
with keyboard shortcuts for all containers, logs, images, and compose services.

## Quick Start

- Press `e` to enter a container shell
- Press `l` to view container logs (live scrolling)
- Press `r` to restart a container
- ... full keybindings below

## Installation

### macOS
brew install jesseduffield/lazydocker/lazydocker

### Linux
Download the [latest release] binary into $PATH.
```

## Anti-Pattern

```markdown
# MyProject

## Installation
Install these dependencies first... [20 lines of setup]

## Configuration
Set these environment variables... [more config]

## API
[large API reference block]

## Contributing
[contributing guide]
```

Problem: the reader gets 50 lines in and still doesn't know what this is or whether they need it.
```

- [ ] **Step 2: Commit**

```bash
git add rules/readme-structure.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite readme-structure rule in English
EOF
)"
```

### Task 10: Write rules/commit-message.md (EN)

**Files:**
- Create: `rules/commit-message.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# Commit Message Rule

**Rule:** Commit messages MUST record WHY, not WHAT. Each commit body MUST answer four questions.

## The Four Questions

1. **What problem forced this change?** — Symptom, scope of impact
2. **What alternatives were considered?** — Why not take a simpler path
3. **What are the trade-offs or side effects?** — Cost, known limitations, benchmarks
4. **What might surprise someone?** — Non-obvious decisions or known gaps

## Example

### Good

```
payment: fix PayPal callback signature rejection on webhook replay

Users reported ~5% of PayPal payment callbacks were 403s over the weekend.
Root cause: PayPal occasionally replays the same webhook event (likely their
retry mechanism), and our nonce-based idempotency check returned 403 on the
second occurrence.

Alternatives considered:
- Option A: Return 200 for duplicate nonces (idempotent semantics). Simple,
  but buries the discrepancy in logs, making ops debugging hard.
- Option B: Log duplicate events, return 200, and notify ops.

Chose B. Added a deduplication_log table to track repeats.

Known limitation: currently only covers PayPal. Stripe webhook signature
verification (in billing/stripe_webhook.py) hasn't been synced yet — planned
for next week.
```

### Bad

```
fix payment bug
```
```

- [ ] **Step 2: Commit**

```bash
git add rules/commit-message.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite commit-message rule in English
EOF
)"
```

### Task 11: Write rules/code-review.md (EN)

**Files:**
- Create: `rules/code-review.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# Code Review Rule

**Rule:** Code review is for everyone — not just senior engineers. Review code, not people. Offer actionable suggestions. Ask, don't command.

## The Seven Principles

### 1. Review the code, not the person

- BAD: "Your code is hard to read"
- GOOD: "This function took me a couple reads to follow"

### 2. Prefer actionable suggestions

- BAD: "Don't use global variables"
- GOOD: "Could this be a config dataclass instead of a global?"

### 3. Ask rather than command

Questions spark discussion; commands shut it down.

- BAD: "Handle the null case"
- GOOD: "What happens if X is null here?"

### 4. Explain WHY

Every suggestion MUST include the reasoning behind it.

- BAD: "Use a constant here"
- GOOD: "Use a constant here so the timeout can be tuned per environment"

### 5. Distinguish blocking from suggestions

Label each comment so the author knows what MUST change vs. what's optional:

- `[blocking]` — MUST be addressed before merge
- `[suggestion]` — worth considering, author's call
- `[nit]` — trivial, feel free to ignore

### 6. Praise good work

Call out clever solutions and clean implementations. It tells the author what patterns to keep using.

```
The error recovery logic here is really clean, especially the retry
backoff strategy. Let's use this as the reference pattern for similar
external calls going forward.
```

### 7. Know when to stop

Contributor time and energy are finite. Focus on the big things (correctness, security, performance, maintainability). Small issues can be cleaned up later.
```

- [ ] **Step 2: Commit**

```bash
git add rules/code-review.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite code-review rule in English
EOF
)"
```

### Task 12: Write rules/code-style-declaration.md (EN)

**Files:**
- Create: `rules/code-style-declaration.md` (overwrite)

- [ ] **Step 1: Write the English rule**

```markdown
# Code Style Declaration Rule

**Rule:** Before writing ANY code, you MUST declare the project's code style and conventions. Starting without a style declaration is not allowed.

## Required Declarations

### 1. Style Baseline

Which public style guide does the project follow:

- Java: Google Java Style / Alibaba Java Coding Guidelines / Sun Code Conventions
- JavaScript/TypeScript: Airbnb / StandardJS / Prettier default / team custom
- Python: PEP 8 / Black / Google Python Style
- Go: Effective Go / Go Code Review Comments
- Other languages: cite the reference standard

### 2. Preference Decisions

Take a stance on common disagreements:

- **Branching**: if-else vs. strategy pattern vs. switch — at what complexity threshold?
- **Function length**: max lines? How to split when exceeded?
- **State management**: immutability-first (val/final) or mutable-by-default?
- **Error handling**: exceptions vs. Result type vs. return codes — pick one
- **Comment style**: JSDoc/JavaDoc scope — all public methods, or only non-obvious ones?

### 3. Forbidden Patterns

List patterns explicitly banned in this project:

- MUST NOT silently swallow exceptions (`catch (Exception e) {}`)
- MUST NOT use `System.out.println` instead of logging
- MUST NOT use Lombok `@Data` (over-generates getters/setters)

## Where to Record

Write the style declaration in the project's `CLAUDE.md`:

```markdown
## Code Style

- **Style guide**: Google Java Style
- **Branch logic**: if-else for ≤3 branches; strategy pattern for 4+
- **Function length**: ≤40 lines
- **State**: val/final preferred, mutable only with explicit reason
- **Error handling**: exceptions for unrecoverable, Result<T> for business errors
- **Comments**: JavaDoc on all public methods
- **Forbidden**: `.*` imports, wildcard generics, raw types
```

## Scope

All new projects before first code. Existing projects: add the declaration on first modification if CLAUDE.md doesn't already include it.
```

- [ ] **Step 2: Commit**

```bash
git add rules/code-style-declaration.md
git commit -m "$(cat <<'EOF'
i18n(L2): rewrite code-style-declaration rule in English
EOF
)"
```

---

## Layer 3: English Rationale Rewrite

Each task: write the English rationale independently (not translation), incorporating AI-specific risk content from Layer 1.

### Task 13: Write rationale/code-change-log.md (EN)

**Files:**
- Create: `rationale/code-change-log.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Code Change Logs

## The Trigger

You inherit a project last touched six months ago. Production is down. You open git log. The commits say "fix", "update", "change stuff". You have no idea what was changed, why, or which "fix" might have caused the current outage. You spend hours reverse-engineering context that someone once had but never wrote down.

This is the cost of no change log.

## The Core Insight

Code changes are decisions frozen in time. A diff shows WHAT moved. A commit message shows WHY the change was made (at the feature level). But neither captures:

- The root cause that led to this specific fix
- The before/after code comparison with rationale per changed block
- Which changes were deliberate fixes vs. incidental side effects

A structured change log fills this gap. It makes the decision-making process visible.

## AI-Specific Risk

AI-assisted coding amplifies this problem in three ways:

**Silent collateral changes.** When you ask AI to "fix this bug", it may adjust three related files — but only tell you about the bug fix. Those collateral changes might be correct cleanup, or they might be misunderstandings of adjacent logic. Without a change log, you can't distinguish them two weeks later. The git diff will show four changed blocks with no indication that only one was the actual fix.

**No author memory to fall back on.** Hand-written code comes with implicit memory: you remember roughly what you changed and why, because you held the reasoning in your head. With AI-assisted coding, you're a reviewer, not the author. You didn't hold every line in working memory as it was written. The structured change log replaces the author memory you never had.

**Invisible prompt iteration.** A feature may go through 5 prompt iterations and 3 abandoned approaches before settling. If the final approach's rationale isn't recorded, the next person will wonder "why not use the simpler X approach", spend half a day trying X, discover it doesn't work — and this exact lesson was learned three months ago and lost because nobody wrote it down.

In short: for hand-written code, change logs are nice to have. For AI-assisted coding, they're the only thread connecting code to context.

## Consequences Without This Rule

- The same bug gets fixed and re-introduced in cycles
- Refactoring destroys historical fixes because nobody knows that weird-looking `if` was load-bearing
- Production incidents are debugged via `git blame` + guessing
```

- [ ] **Step 2: Commit**

```bash
git add rationale/code-change-log.md
git commit -m "$(cat <<'EOF'
i18n(L3): write code-change-log rationale in English
EOF
)"
```

### Task 14: Write rationale/meaningful-comments.md (EN)

**Files:**
- Create: `rationale/meaningful-comments.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Meaningful Comments

## The Trigger

You read a comment: `// validate input`. The code below it has three nested loops, a regex, and bitwise operations. The comment told you nothing. Then you see a bare constant `1492` sitting in the middle of a function. Is it arbitrary? Protocol-mandated? The result of an April debugging session? You have no way to know.

## The Core Insight: Comments' Enemy Is WHAT

Code naturally expresses WHAT — it's an executable description of steps. But code cannot express:

- Why this step, not the alternative
- What the boundary conditions are and why
- What was tried before and why it didn't work
- What will break if you change this

Comments should fill these gaps. A comment that merely translates code into natural language ("iterate the list, filter nulls" for `[x for x in list if x]`) is noise. Delete it.

## AI-Specific Risk

AI-generated code has a dangerous property: it always *looks* correct. Clean logic, good naming, perfect formatting — and this surface correctness makes real problems harder to spot.

**AI excels at writing useless comments.** Training data is full of `// increment counter` and `// validate input` — comments that restate WHAT. AI learned the form of commenting but not the substance. Without a filter, over half of AI-generated comments are noise, and the real WHYs go unrecorded. The seven-type taxonomy is that filter: if your comment doesn't fit one of the seven, don't write it.

**AI's constants are plausible hallucinations.** Ask AI "what timeout should I use here" and it may output `TIMEOUT = 30` — the 30 came from some training example, not from your environment. If the rule requires constant rationale, `TIMEOUT = 30  # AI-suggested, not yet tested in prod` is the comment that saves someone from blindly trusting it.

**AI has no "I got burned by this" memory.** You spend two hours debugging a subtle issue, and AI helps write the fix — but AI doesn't know about your two hours of pain. If the fix isn't annotated as a lesson-learned comment, the next refactor may delete that hard-won fix as "redundant code", and the bug returns.

**AI triggers "Why not X" at maximum frequency.** AI picks solutions based on statistical frequency, not project-specific constraints. It may pick 10 different JSON parsing approaches across 10 projects — each individually reasonable, collectively disastrous in one codebase. When you deliberately reject AI's suggested "standard approach", you MUST comment why, or the next session will "fix" it back.
```

- [ ] **Step 2: Commit**

```bash
git add rationale/meaningful-comments.md
git commit -m "$(cat <<'EOF'
i18n(L3): write meaningful-comments rationale in English
EOF
)"
```

### Task 15: Write rationale/readme-structure.md (EN)

**Files:**
- Create: `rationale/readme-structure.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Funnel-Structured READMEs

## The Trigger

You find a GitHub repo whose name matches what you need. You open the README. The first 50 lines are a dependency list, environment variables, and a Docker startup command. You scroll to the bottom and still don't know what the thing actually does. You close the tab and move on.

Most README readers stay for seconds, not minutes.

## The Core Insight: Funnel Psychology

A funnel structure matches a stranger's decision process:

1. **What does it do?** — The "matching" phase. One sentence + one image lets the reader decide: "Can this solve my problem?" If not, you've saved everyone's time.
2. **Why should I care?** — The "motivation" phase. So many similar tools exist. Why spend time on this one?
3. **How do I use it?** — The "fantasy" phase. Show the end result. Build desire: "I want this."
4. **How do I install it?** — The "action" phase. Installation steps only matter after the reader has decided to commit.

The reverse — the default in most mediocre READMEs — demands investment before establishing value. Most people won't invest.

## AI-Specific Risk

AI-assisted projects ship fast and iterate often — and the README is frequently forgotten because AI won't maintain it for you.

**AI's default README structure is anti-funnel.** Training data is full of READMEs that open with installation. When you say "write me a README", AI tends to generate Installation → Configuration → API — because that's what most READMEs in its training data look like. Unless you explicitly require funnel order, AI won't produce it. This rule locks in the correct structure so AI follows it.

**Code-README sync is a one-way disconnect.** AI adds a core feature and changes two API endpoints — it updates the code but doesn't proactively update the README. Three months later, the README describes features that no longer exist while omitting the ones that do. A correct-but-stale README is worse than no README: it actively misleads new users into following broken instructions.

**AI can't narrate.** AI can list every API endpoint exhaustively. It cannot judge "what does a new user need to see first?" The funnel's value is in the human-curated narrative order — you must tell AI what order to present information, rather than letting it dump an API reference.
```

- [ ] **Step 2: Commit**

```bash
git add rationale/readme-structure.md
git commit -m "$(cat <<'EOF'
i18n(L3): write readme-structure rationale in English
EOF
)"
```

### Task 16: Write rationale/commit-message.md (EN)

**Files:**
- Create: `rationale/commit-message.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Complete Commit Messages

## The Trigger

You run `git blame` to understand why a line of code from three years ago exists. The commit message says "fix". No issue link, no problem description, no discussion of alternatives. Is that line still needed? Did the original bug go away? You don't know. You leave the line in place. Forever.

## The Core Insight: Commits Are Time Machines

Every code change corresponds to a decision moment. The context at that moment — the symptom, the alternatives considered, the trade-off reasoning — vanishes unless it's written into the commit message. Code evolves, but "why the code became this way" lives only in commit history.

Code tells you WHAT. Comments (at their best) tell you WHY locally — within a function or file. Commit messages tell you WHY globally — the motivation and context behind an entire change set.

## AI-Specific Risk

AI-assisted coding inflates commit frequency. What was 3-5 commits per day becomes 20-30. Higher frequency makes message quality more critical, not less.

**AI's default commit messages are useless.** If you let AI generate a commit message without giving it a template, it produces "fix bug", "update code", "refactor" — it has no memory of your change context and can only guess from the diff. You MUST give it the four-question template to produce something useful.

**Batch commits obscure individual decisions.** With AI, you might change 5 files across 3 features in 30 minutes and commit them together. If the commit message doesn't decompose each decision, `git blame` points to a giant mixed commit that explains nothing.

**WHY matters more than WHAT, and WHY is what AI can't provide.** AI can generate a perfect diff description — it can see which lines changed. But why option B over option A? Why avoid a seemingly better pattern? The AI doesn't know. Only you do. And these are precisely the details that are scarcest three months later during an incident.
```

- [ ] **Step 2: Commit**

```bash
git add rationale/commit-message.md
git commit -m "$(cat <<'EOF'
i18n(L3): write commit-message rationale in English
EOF
)"
```

### Task 17: Write rationale/code-review.md (EN)

**Files:**
- Create: `rationale/code-review.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Code Review

## The Trigger

A developer spends two weeks building a feature and merges directly to main. A week later, production breaks. No one knows how that logic works because only the author ever read it. Worse: three other modules use the same pattern, but each implemented it differently — everyone wrote their own version.

## The Core Insight: Four Values of Review

### 1. Knowledge Distribution

Unreviewed code = the author is the sole expert. When the author is on vacation, leaves the company, or simply forgets — the code becomes a black box. Review ensures at least two people understand every line.

### 2. Hidden Assumptions Exposed

Newcomers and developers from different domains ask "why is this done this way?" These questions expose assumptions that were never documented or simplified. Authors develop blind spots from prolonged exposure to the codebase ("this goes without saying"). An outside perspective breaks through them.

### 3. Pattern Convergence

Without review, everyone writes in their own style. Three weeks later, the same feature has three implementations. Review catches this: "we discussed this pattern before — let's use approach X consistently." The codebase converges instead of diverging.

### 4. Accelerated Learning

Review exposes everyone to different corners of the codebase and different problem-solving approaches. For vibe coding specifically, review is also the checkpoint for catching suboptimal patterns in AI-generated code.

## AI-Specific Risk

AI generates code far faster than humans can review it. This creates an asymmetry: 200 lines of code in 30 seconds from AI, but 20 minutes to review it properly. Without review discipline, generation speed overwhelms review capacity.

**AI bugs live in different places than human bugs.** Humans err in complex logic. AI errs in edge cases, concurrency safety, resource cleanup, and error-handling paths — low-frequency patterns in training data. Worse, AI code works on the happy path, creating a false sense of security that lowers review vigilance.

**AI produces divergent styles across sessions.** This is why the review rule emphasizes pattern convergence. Without review, AI implements the same feature three different ways across three sessions — because each invocation samples from a different region of its style distribution. Review is the mechanism that re-converges these divergences.

**AI amplifies the knowledge distribution problem.** A human author at least has ownership and memory of their code. With AI assistance, you're the prompt author but not the code author — you may not fully understand every line AI generated, nor remember why it chose a particular implementation. If that code merges unreviewed, it's a double black box: even the "author" doesn't fully understand it.
```

- [ ] **Step 2: Commit**

```bash
git add rationale/code-review.md
git commit -m "$(cat <<'EOF'
i18n(L3): write code-review rationale in English
EOF
)"
```

### Task 18: Write rationale/code-style-declaration.md (EN)

**Files:**
- Create: `rationale/code-style-declaration.md`

- [ ] **Step 1: Write the English rationale**

```markdown
# Why Code Style Declarations

## The Trigger

A new project starts. AI generates the first piece of code — Python, 4-space indent, type hints here and there, a mix of try-except and return-None for errors. The next day, AI generates another piece — 2-space indent, uses `raise` instead of `return None`. Three days in, four styles coexist in a single file.

## The Core Problem

AI training data covers every style. It's not on your team. Ask the same prompt twice and you may get code in two different styles. Without a declared style, AI randomly samples from every style it has ever seen — and a day's output can look like four different authors wrote it.

The style declaration is a global constraint. It turns "every response may have a different style" into "every response follows one standard."

## Why "Just Infer From Existing Code" Doesn't Work

- Existing code may already be inconsistent (written before the declaration existed)
- Some preferences are strategic (when to use the strategy pattern) — you can't infer them from code that only shows the current choice
- Forbidden patterns are invisible in code — you can see `catch (Exception e) {}` sitting there, but you can't see that it's forbidden

## AI-Specific Risk

Hand-written code has natural style consistency — one brain, one pair of hands. AI-assisted coding faces infinite virtual authors: each AI response may draw from a different region of its training distribution.

**Style randomness is systematic, not incidental.** This isn't a bug in a particular model — it's inherent to all LLMs. Training data covers all styles. Models learn all styles. Without constraints, they sample randomly. A 500-line file generated across 5 sessions can end up with 3 indentation styles, 2 error-handling patterns, and 4 naming conventions. The style declaration is the global lock on this randomness.

**Forbidden patterns must be explicit; AI won't infer them.** Your project bans Lombok `@Data`, but AI doesn't know that — it sees `@Getter` and `@Setter` in your code, infers "this project uses Lombok", and helpfully adds `@Data` in the next block. Forbidden patterns are the briefing you owe the AI: which common practices are off-limits here and why.

**Even with existing code, correct inference is impossible.** Style-guide-level decisions ("use strategy pattern when branches exceed 3") can't be reverse-engineered from code that only shows the current state. You see an if-else chain; you don't see the rule that says it should have been a strategy pattern. The style declaration fills this information gap before AI makes its first guess.
```

- [ ] **Step 2: Commit**

```bash
git add rationale/code-style-declaration.md
git commit -m "$(cat <<'EOF'
i18n(L3): write code-style-declaration rationale in English
EOF
)"
```

---

## Side Effects

### Task 19: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md:22-30`

- [ ] **Step 1: Update the Rules to Load table with refreshed English descriptions**

Change the table to:

```markdown
## Rules to Load

| Rule | File | Core Requirement |
|------|------|-----------------|
| Code Change Log | `rules/code-change-log.md` | After every Edit/Write, create a change log in `docs/变更记录/` with root cause analysis and before/after code |
| Meaningful Comments | `rules/meaningful-comments.md` | Comments MUST explain WHY, not WHAT. Seven types: TODO, references, correctness justification, lessons learned, magic constant rationale, load-bearing details, "why not X" |
| README Structure | `rules/readme-structure.md` | READMEs MUST follow funnel order: what → why care → how to use → how to install. Show usage before installation |
| Commit Messages | `rules/commit-message.md` | Commit body MUST answer: what problem forced this change, alternatives considered, trade-offs, surprises |
| Code Review | `rules/code-review.md` | Review code not people. Offer actionable suggestions. Ask, don't command. Distinguish blocking from suggestion. Know when to stop |
| Code Style Declaration | `rules/code-style-declaration.md` | Before ANY code, MUST declare: style baseline, preference decisions (if-else vs strategy, immutability), forbidden patterns |
```

(Table is already in English — this is a refresh pass to align descriptions with the rewritten rule files.)

- [ ] **Step 2: Update Repository Structure to reflect rationale/zh/**

Change:
```
rationale/      # Rationale files — why the rule exists, consequences of skipping it
```
To:
```
rationale/      # Rationale files (English) — why the rule exists, consequences of skipping it
rationale/zh/   # Rationale files (Chinese, reference)
```

- [ ] **Step 3: Commit**

```bash
git add CLAUDE.md
git commit -m "$(cat <<'EOF'
i18n: update CLAUDE.md to reflect bilingual rationale structure
EOF
)"
```

### Task 20: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Add language badge and make README bilingual**

Replace the current Chinese-only README with an English-first version with Chinese reference:

```markdown
# vibe-coding-sops

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/rules-6-4caf50.svg" alt="Rules: 6">
  <img src="https://img.shields.io/badge/status-active-success.svg" alt="Status: Active">
  <img src="https://img.shields.io/badge/vibe%20coding-essential-f39f37.svg" alt="Vibe Coding: Essential">
  <img src="https://img.shields.io/badge/lang-en--CN-lightgrey.svg" alt="Language: EN/CN">
</p>

> A collection of rules for AI-assisted coding (vibe coding). Each rule defines what to do and how. Each rationale explains why.
>
> AI 辅助编程（vibe coding）规则集合。规则以英文为主（AI 执行），理由中英双语（人阅读）。

## Why You Need This

AI-assisted coding is fast, but speed isn't quality. Without rule constraints, vibe coding leads to:

- Code changed — but nobody knows what changed (no change log)
- `git blame` returns "fix bug" three months later — zero information
- AI-generated code looks correct but hides edge-case problems
- Three coding styles appear in the same project within three days

This repo writes down the **rules** and **rationale** that vibe coding MUST follow, loaded into Claude Code's project memory to ensure every AI-assisted coding session runs under the same constraints.

> 中文用户请查看 [rationale/zh/](rationale/zh/) 目录获取中文版理由说明。

## Quick Start

Clone this repo and reference the rules in your project's CLAUDE.md:

```
# In your project's CLAUDE.md:
This project follows the rules in vibe-coding-sops. See:
- Code Change Log: rules/code-change-log.md
- Meaningful Comments: rules/meaningful-comments.md
- README Structure: rules/readme-structure.md
- Commit Messages: rules/commit-message.md
- Code Review: rules/code-review.md
- Code Style Declaration: rules/code-style-declaration.md
```

## Rule Index

| # | Rule | Description |
|---|------|-------------|
| 1 | [Code Change Log](rules/code-change-log.md) | After every code change, create a structured change log with root cause analysis + before/after code |
| 2 | [Meaningful Comments](rules/meaningful-comments.md) | Comments explain WHY, not WHAT. Seven types: TODO, references, correctness, lessons learned, magic constants, load-bearing details, "why not X" |
| 3 | [README Structure](rules/readme-structure.md) | Funnel organization: what → why care → how to use → how to install. Usage before installation |
| 4 | [Commit Messages](rules/commit-message.md) | Commit body answers: what problem, alternatives considered, tradeoffs, surprises |
| 5 | [Code Review](rules/code-review.md) | Seven principles: review code not people, actionable suggestions, ask don't command, explain why, label blocking vs suggestion, praise good work, know when to stop |
| 6 | [Code Style Declaration](rules/code-style-declaration.md) | Before any code, declare style baseline, preference decisions, forbidden patterns |

Each rule's rationale (WHY) is in [rationale/](rationale/) (English) and [rationale/zh/](rationale/zh/) (Chinese).

## Repository Structure

```
vibe-coding-sops/
├── rules/           # Rule files — what to do, how to do it (English)
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   ├── code-review.md
│   └── code-style-declaration.md
├── rationale/       # Rationale files — why the rule exists (English)
│   ├── code-change-log.md
│   ├── meaningful-comments.md
│   ├── readme-structure.md
│   ├── commit-message.md
│   ├── code-review.md
│   └── code-style-declaration.md
│   └── zh/          # Rationale files (Chinese reference)
│       ├── code-change-log.md
│       ├── meaningful-comments.md
│       ├── readme-structure.md
│       ├── commit-message.md
│       ├── code-review.md
│       └── code-style-declaration.md
├── docs/
│   └── 变更记录/
├── CLAUDE.md
├── LICENSE
└── README.md
```

## License

MIT © 2026 Siborne
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "$(cat <<'EOF'
i18n: rewrite README as English-first with bilingual index
EOF
)"
```

---

## Execution Order

Tasks MUST run sequentially within each layer to maintain atomic git history. Layer 1 must complete before Layer 2; Layer 2 before Layer 3; Side Effects last.

```
Task 1 → Task 2 → Task 3 → Task 4 → Task 5 → Task 6
    ↓
Task 7 → Task 8 → Task 9 → Task 10 → Task 11 → Task 12
    ↓
Task 13 → Task 14 → Task 15 → Task 16 → Task 17 → Task 18
    ↓
Task 19 → Task 20
```
