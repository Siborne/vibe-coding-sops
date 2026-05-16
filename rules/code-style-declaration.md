# 代码风格声明规则

每次开发前，必须在项目上下文（CLAUDE.md 或对话初始 prompt）中声明本项目遵循的代码风格和约定。不允许没有风格声明就开始写代码。

## 必须声明的维度

### 1. 风格基准

项目基于哪套公开规范：

- Java: Google Java Style / Alibaba Java Coding Guidelines / Sun Code Conventions
- JavaScript/TypeScript: Airbnb / StandardJS / Prettier default / 团队自定义
- Python: PEP 8 / Black / Google Python Style
- Go: Effective Go / Go Code Review Comments
- 其他语言：注明参考标准

### 2. 决策偏好

明确团队对常见分歧的立场：

- **分支逻辑**: if-else vs. 策略模式 vs. switch — 什么复杂度下切换？
- **函数长度**: 上限多少行？超出如何拆分？
- **状态管理**: 不变优先（val/final）还是可变优先？
- **错误处理**: 异常 vs. Result 类型 vs. 返回值 — 统一用哪种？
- **注释风格**: JSDoc / JavaDoc 的必要范围 — 所有 public 方法？还是仅非显而易见的？

### 3. 禁止项

列出项目明确禁用的模式：

- ❌ 禁止 `catch (Exception e) {}` 吞异常
- ❌ 禁止 `System.out.println` 替代日志
- ❌ 禁止 Lombok `@Data`（过度生成 getter/setter）

## 记录位置

风格声明写入项目的 `CLAUDE.md`，格式：

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

## 适用范围

所有新项目首次编码前。存量项目如果 CLAUDE.md 中尚未包含此声明，在第一次修改时补充。
