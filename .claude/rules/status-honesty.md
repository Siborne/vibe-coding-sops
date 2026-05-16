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
