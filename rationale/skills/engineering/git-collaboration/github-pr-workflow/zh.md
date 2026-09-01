# 为什么需要 GitHub PR Workflow

## 触发场景

一个 Agent 参与一个共享 GitHub 仓库的开发，直接向 `main` 提交了代码。push 之后才意识到：CI 挂了、测试没过、reviewer 还没看过代码，而 `main` 是团队所有人依赖的稳定分支。改动直接在主干上线，其他协作者的本地 `main` 瞬间与远端不一致。

另一个场景：Agent 在一个 feature 分支上开发，但忘了给 PR 加 reviewer、忘了跑 linter、覆盖率没达标。代码合进 `develop` 后，团队 review 才发现逻辑有漏，只能返工。

## 核心问题

Agent 默认的倾向是"改完就提交"，因为单独看每一步好像都在推进任务。但多人协作仓库的正确性不取决于"代码能不能跑"，而取决于"是否经过约定的流程"。

没有一套固定的 Git 协作流程时，Agent 的行为会随机化：

- 有时直接提交 `main`，破坏稳定分支
- 有时 fork/分支/PR 混乱，PR 目标指错
- 有时跳过测试、linter、覆盖率，把未验证的代码合进去
- 有时忽略 reviewer 的评论，直接 merge

问题不在于某一次操作，而在于**每次操作的规范不一致**。规则的作用是让 Agent 在每次协作任务中都走同一条可预期、可审计的流水线。

## 为什么必须是一个独立 skill 而非依赖临时提示

**协作流程步骤多且有顺序依赖。** 一个完整的 Fork → Feature Branch → PR → Review → Merge 流程有 20 多个环节，每个环节都有前置条件。靠临时在 prompt 里写"注意用 PR 流程"远远不够——Agent 会在"感觉差不多"的环节跳过关键检查。

**规范需要可复制。** Fork first、基于 develop 开发、feature/* 分支命名、Squash and Merge、2 个 LGTM、禁 force push main——这些是企业协作的强约束。把它们固化为一个 skill，任何 Agent 参与仓库开发时都能加载同一套标准，不依赖参与者的 Git 熟练度。

**流程失败的成本是不对称的。** 一次正确的流程执行只需要多几个命令，但一次错误的 `push --force main` 或"跳过 review 直接 merge"可能让整个团队的回滚成本翻倍。skill 把"低概率高压后果"的操作也纳入强制门槛。

## 与 rules/branch-pr-workflow.md 的关系

本 skill 与仓库中的"分支与 PR 工作流规则"（`rules/branch-pr-workflow.md`）共同约束 Git 协作，但定位不同：

- **rule** 定义**必须遵守的原则与检查清单**：分支命名格式、PR 范围、rebase 优先、提交前 A/B/C 三层检查、reviewer 合并与清理。
- **skill** 提供**可执行的完整操作序列**：从 Fork/Clone 到 Feature Branch、从测试/覆盖率/lint 到 PR 描述/Reviewer、直到 Squash & Merge 的逐步命令与判据。

两者配合：rule 管"必须做到什么"，skill 管"一步步怎么执行"。

## 没有这个 skill 的后果

- Agent 直接操作 `main`，破坏稳定分支，协作者同步失控
- PR 流程流于形式：无 reviewer、无 CI、无覆盖率，review 形同虚设
- 提交信息、分支命名各写各的，历史不可追溯
- 协作规范靠口头约定，新加入的 Agent/成员无法自动获得统一流程
- 高风险操作（force push、跳过 review）没有强制拦截门槛，出错成本高
