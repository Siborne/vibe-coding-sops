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
