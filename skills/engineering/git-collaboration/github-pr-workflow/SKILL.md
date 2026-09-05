---
name: github-pr-workflow
title: GitHub PR Workflow
description: 严格遵循 GitHub Fork + Feature Branch + Pull Request 的企业级协作开发流程，禁止直接提交 main。
type: skill
category: engineering
subcategory: git-collaboration
triggers:
  - Agent 参与 GitHub 仓库的代码修改任务
  - 需要按 Fork/Feature Branch/PR 流程协作开发
tags:
  - git
  - collaboration
  - pull-request
---

# GitHub PR Workflow

## Description

严格遵循 GitHub Fork + Feature Branch + Pull Request 的企业级协作开发流程。

本 Skill 适用于 Agent 参与 GitHub 仓库开发时的所有代码修改任务。

核心原则：

> **Never directly commit to `main`. All changes must go through a Feature Branch and Pull Request.**

---

## 1. Branch Protection

### 🚫 禁止直接操作 `main`

Agent **不得**：

- 直接在 `main` 分支开发
- 直接向 `main` commit
- 直接向 `main` push
- 对 `main` 执行 `force push`
- 绕过 Pull Request 合并代码
- 修改或删除 `main` 分支
- 使用 `git push --force` / `git push -f` 操作受保护分支

如果当前处于 `main`：

```bash
git branch --show-current
```

发现当前分支是：

```text
main
```

必须先停止代码修改，并切换到正确的开发流程。

---

# 2. Repository Workflow

标准流程：

```text
Fork Repository
      ↓
Clone Fork
      ↓
Checkout develop
      ↓
Create Feature Branch
      ↓
Implement Feature
      ↓
Write Unit Tests
      ↓
Write Integration Tests
      ↓
Run Tests
      ↓
Check Coverage
      ↓
Run Linter
      ↓
Fix All Issues
      ↓
Commit
      ↓
Push Feature Branch
      ↓
Create Pull Request
      ↓
Code Review
      ↓
Resolve All Threads
      ↓
CI/CD Pass
      ↓
At Least 2 LGTM
      ↓
Squash and Merge
      ↓
develop
```

---

# 3. Fork First

如果 Agent 没有直接写入上游仓库的权限，应优先 Fork 用户仓库。

目标结构：

```text
upstream repository
        │
        └── Fork
              │
              └── agent's repository
```

Agent 应在自己的 Fork 中进行开发。

不要直接修改 upstream repository 的 `main`。

---

# 4. Develop Branch

Feature 开发应基于：

```text
develop
```

而不是：

```text
main
```

首先同步 `develop`：

```bash
git checkout develop
git pull origin develop
```

如果本地不存在 `develop`：

```bash
git fetch origin
git checkout -b develop origin/develop
```

---

# 5. Create Feature Branch

所有功能必须创建独立 Feature Branch。

命名格式：

```text
feature/<feature-name>
```

例如：

```text
feature/confession
feature/login
feature/user-profile
feature/message-service
```

本任务示例：

```bash
git checkout develop
git pull origin develop

git checkout -b feature/confession
```

---

# 6. Implement the Feature

Agent 应只在 Feature Branch 中进行代码修改。

例如：

```text
feature/confession
```

实现目标功能。

代码应遵循项目现有：

- Architecture
- Coding Style
- Naming Convention
- Dependency Management
- Error Handling
- Logging
- Testing Convention

不得为了完成简单功能而随意重构无关代码。

---

# 7. Unit Tests

每个新增核心功能都必须有对应的 Unit Test。

至少覆盖：

- 正常流程
- 边界条件
- 异常情况
- 参数校验
- 核心业务逻辑

例如：

```text
src/
├── confession/
│   ├── confession.service.ts
│   └── confession.controller.ts
│
└── tests/
    └── confession.service.test.ts
```

---

# 8. Integration Tests

涉及多个模块、数据库、HTTP API、消息队列或外部依赖的功能，应增加 Integration Test。

例如：

```text
Unit Test
    ↓
Service

Integration Test
    ↓
Controller
    ↓
Service
    ↓
Repository
    ↓
Database
```

Integration Test 必须验证真实模块之间的协作，而不是简单重复 Unit Test。

---

# 9. Code Coverage

在提交代码之前必须执行测试覆盖率检查。

目标：

```text
Code Coverage >= 95%
```

重点关注：

- Statements
- Branches
- Functions
- Lines

如果项目已有 Coverage 配置，应遵循项目配置。

如果 Coverage 低于 95%：

```text
DO NOT COMMIT
```

必须补充测试后重新执行。

---

# 10. Linter

提交之前必须执行项目 Linter。

例如：

```bash
npm run lint
```

或者：

```bash
pnpm lint
```

或者：

```bash
./gradlew check
```

具体命令必须根据项目实际配置确定。

要求：

```text
Lint Errors = 0
```

不得：

- 忽略 Lint Error
- 使用大量 disable 注释绕过检查
- 修改 Linter 配置来掩盖问题
- 为了通过检查而降低项目质量

---

# 11. Full Verification

Commit 前至少执行：

```bash
Test
Coverage
Lint
Build
```

理想流程：

```bash
npm test
npm run test:coverage
npm run lint
npm run build
```

具体命令以项目实际配置为准。

必须确保：

```text
Tests        ✅
Coverage     >= 95% ✅
Linter       ✅
Build        ✅
```

---

# 12. Conventional Commits

Commit Message 必须遵循 Conventional Commits。

格式：

```text
<type>(<scope>): <description>
```

常见类型：

```text
feat
fix
refactor
test
docs
chore
perf
build
ci
```

例如：

```text
feat(confession): add confession feature
```

测试：

```text
test(confession): add confession service tests
```

修复：

```text
fix(confession): handle empty confession content
```

不要使用：

```text
update
modify
test
aaa
fix bug
final
final2
```

---

# 13. Commit Strategy

提交前检查：

```bash
git status
git diff
git diff --cached
```

确保：

- 没有无关修改
- 没有 Debug Code
- 没有 Secret
- 没有 API Key
- 没有 Password
- 没有临时文件
- 没有构建产物
- 没有误修改其他模块

然后：

```bash
git add .
```

再次检查：

```bash
git diff --cached
```

确认无误后：

```bash
git commit -m "feat(confession): add confession feature"
```

---

# 14. Push

Feature Branch 应推送到 Agent 自己的 Remote。

例如：

```bash
git push -u origin feature/confession
```

禁止：

```bash
git push origin main
```

禁止：

```bash
git push --force origin main
```

除非用户明确要求执行，并且目标分支确实允许此操作。

---

# 15. Pull Request

完成 Push 后必须创建 Pull Request。

目标：

```text
feature/confession
        ↓
develop
```

而不是：

```text
feature/confession
        ↓
main
```

PR Title 同样建议遵循 Conventional Commits：

```text
feat(confession): add confession feature
```

---

# 16. Pull Request Description

PR Description 必须说明：

## Summary

简要说明实现了什么。

例如：

```text
新增匿名表白功能。
```

## Changes

列出具体修改：

```text
- 新增 Confession Domain
- 新增 Confession Service
- 新增 Confession API
- 新增数据库 Repository
- 新增 Unit Tests
- 新增 Integration Tests
```

## Implementation

说明核心实现思路：

```text
请求进入 Controller 后，
经过 Application Service，
由 Domain Logic 完成核心业务处理，
最终通过 Repository 持久化。
```

## Testing

说明测试情况：

```text
- Unit Tests: Passed
- Integration Tests: Passed
- Coverage: 96.8%
- Linter: Passed
- Build: Passed
```

## Risks

说明潜在风险：

```text
- Database migration required
- API compatibility unchanged
```

---

# 17. Reviewers

PR 创建后，应请求至少 2 名 Reviewer。

如果项目中存在明确的 Code Owners / Maintainers：

优先选择：

```text
Code Owner
Maintainer
Module Owner
Senior Developer
```

PR 中应 @ 相关人员。

例如：

```text
@owner @reviewer1 @reviewer2
```

不要随意 @ 不相关人员。

---

# 18. Code Review

PR 创建后进入 Review 阶段。

Agent 必须关注：

```text
Comments
Review
Requested Changes
Conversation Threads
```

如果 Reviewer 提出问题：

```text
Read Comment
    ↓
Understand Problem
    ↓
Modify Code
    ↓
Run Tests
    ↓
Run Linter
    ↓
Commit
    ↓
Push
```

---

# 19. Resolve All Threads

所有有效 Review Thread 都必须处理。

不能：

- 忽略 Reviewer
- 删除代码逃避评论
- 直接关闭未解决的问题
- 为了 Merge 而强行 Resolve Thread

处理方式：

```text
Reviewer Comment
        ↓
Code Change
        ↓
Reply
        ↓
Resolve Thread
```

如果认为 Reviewer 的建议不合理，应解释原因，而不是直接忽略。

---

# 20. CI/CD

PR 必须等待 CI/CD 完成。

最低要求：

```text
Build        ✅
Unit Test    ✅
Integration  ✅
Lint         ✅
Coverage     >= 95% ✅
```

如果 CI 失败：

```text
DO NOT MERGE
```

必须：

```text
Inspect Failure
    ↓
Fix
    ↓
Push
    ↓
Wait for CI
```

直到所有 Required Checks Passed。

---

# 21. LGTM Requirement

至少获得：

```text
2 × LGTM
```

即至少两名 Reviewer 明确认可代码。

在满足以下条件前，不应请求合并：

```text
2 LGTM
+
All Threads Resolved
+
CI/CD Passed
+
Coverage >= 95%
```

---

# 22. Merge Strategy

最终目标：

```text
feature/confession
        ↓
Pull Request
        ↓
develop
```

推荐：

```text
Squash and Merge
```

保持 `develop` 历史干净。

Merge Commit 应使用清晰的 Conventional Commit 风格，例如：

```text
feat(confession): add confession feature
```

---

# 23. Main Branch Policy

`main` 是稳定版本分支。

正常情况下：

```text
feature/*
     ↓
develop
     ↓
release
     ↓
main
```

Feature 不允许直接进入：

```text
main
```

更不允许：

```text
feature
   ↓
force push
   ↓
main
```

---

# 24. Emergency Exception

只有用户明确要求时，才可以违反默认 Git Workflow。

例如用户明确说：

```text
直接提交到 main
```

或者：

```text
允许 force push
```

否则必须严格遵循本 Skill。

即使用户要求直接修改 `main`，Agent 也应在执行前明确确认，因为这属于高风险 Git 操作。

---

# 25. Final Checklist

创建 PR 前必须确认：

```text
[ ] 当前不是 main
[ ] 基于 develop 创建 Feature Branch
[ ] Feature Branch 命名正确
[ ] 功能实现完成
[ ] Unit Tests 完成
[ ] Integration Tests 完成
[ ] Coverage >= 95%
[ ] Linter Passed
[ ] Build Passed
[ ] 没有 Debug Code
[ ] 没有 Secret
[ ] 没有无关修改
[ ] Commit Message 遵循 Conventional Commits
[ ] Feature Branch 已 Push
[ ] PR Target = develop
[ ] PR Description 完整
[ ] 已请求至少 2 名 Reviewer
```

PR Merge 前必须确认：

```text
[ ] 所有 Review Comments 已处理
[ ] 所有有效 Threads 已 Resolve
[ ] CI/CD 全部 Passed
[ ] Coverage >= 95%
[ ] 至少 2 个 LGTM
[ ] 使用 Squash and Merge
[ ] Merge Target = develop
```

---

# 26. Golden Rule

> **Never touch `main` directly.**

正确：

```text
Fork
 ↓
develop
 ↓
feature/*
 ↓
Test
 ↓
Lint
 ↓
Coverage >= 95%
 ↓
Conventional Commit
 ↓
Push
 ↓
Pull Request
 ↓
Review
 ↓
Resolve Threads
 ↓
CI/CD
 ↓
2 × LGTM
 ↓
Squash & Merge
 ↓
develop
```

错误：

```text
main
 ↓
修改代码
 ↓
commit
 ↓
push
 ↓
force push
```

**如果 Agent 发现自己准备直接 Commit 到 `main`，必须立即停止并切换到 Feature Branch 工作流。**